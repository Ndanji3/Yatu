import 'package:flutter/material.dart';
import 'package:yatu/main.dart';
import 'button.dart';

class LivestockProposalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livestock Proposal Form',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: ProposalFormScreen(),
    );
  }
}

class ProposalFormScreen extends StatefulWidget {
  @override
  _ProposalFormScreenState createState() => _ProposalFormScreenState();
}

class _ProposalFormScreenState extends State<ProposalFormScreen> {
  int _currentStep = 0;
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  final _animalList = List.generate(5, (_) => {"breed": "", "age": "", "value": ""});
  double totalValue = 0;
  String aiSuggestion = "";
  double estimatedPremium = 0;
  String riskLevel = "Unknown";

  // Vet suggestion mock list
  List<Map<String, dynamic>> vetList = [
    {"name": "Dr. John Mwansa", "location": "Lusaka Central", "distance": "5 km", "rating": 4.8},
    {"name": "Dr. Mwaka Phiri", "location": "Kafue", "distance": "12 km", "rating": 4.6},
    {"name": "Dr. Bright Zulu", "location": "Chongwe", "distance": "18 km", "rating": 4.7},
  ];

  // Calculate premium & risk
  void _calculateTotal() {
    totalValue = 0;
    for (var animal in _animalList) {
      double val = double.tryParse(animal["value"] ?? "0") ?? 0;
      totalValue += val;
    }
    _updateAISuggestion();
  }

  void _updateAISuggestion() {
    if (totalValue > 100000) {
      aiSuggestion = "💡 Tip: Your herd value is very high. Consider Large Herd Catastrophe cover.";
      riskLevel = "High";
    } else if (totalValue > 50000) {
      aiSuggestion = "💡 Tip: Your herd is medium-high value. Scaled Indemnity could be ideal.";
      riskLevel = "Medium";
    } else if (totalValue > 0) {
      aiSuggestion = "💡 Tip: Single Animal Cover might be most cost-effective.";
      riskLevel = "Low";
    } else {
      aiSuggestion = "💡 AI Suggestion: Fill in your animal details to get tailored advice.";
      riskLevel = "Unknown";
    }

    estimatedPremium = totalValue * (riskLevel == "High"
        ? 0.06
        : riskLevel == "Medium"
        ? 0.045
        : 0.03);
    setState(() {});
  }

  void _showAIResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("AI Risk & Premium Analysis"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("📊 Risk Level: $riskLevel",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: riskLevel == "High"
                        ? Colors.red
                        : riskLevel == "Medium"
                        ? Colors.orange
                        : Colors.green)),
            SizedBox(height: 8),
            Text("💰 Estimated Annual Premium: K${estimatedPremium.toStringAsFixed(2)}"),
            SizedBox(height: 12),
            Text(aiSuggestion),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }

  void _showVetFinder() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        padding: EdgeInsets.all(12),
        children: [
          Text("🐄 Nearby Veterinary Surgeons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...vetList.map((vet) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Icon(Icons.medical_services, color: Colors.green[800]),
                ),
                title: Text(vet["name"]),
                subtitle: Text("${vet["location"]} • ${vet["distance"]} away"),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 18),
                    Text(vet["rating"].toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("📅 Vet ${vet["name"]} booked for assessment!")),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Livestock Proposal Form"), centerTitle: true),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 4) {
            setState(() => _currentStep += 1);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("✅ Form Submitted")));
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) setState(() => _currentStep -= 1);
        },
        steps: [
          Step(
            title: Text("A. Proposer Details"),
            content: Column(
              children: [
                TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
                TextField(decoration: InputDecoration(labelText: "Postal Address")),
                TextField(controller: _locationController, decoration: InputDecoration(labelText: "Farm Location")),
                TextField(decoration: InputDecoration(labelText: "Telephone Number"), keyboardType: TextInputType.phone),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.smart_toy),
                  label: Text("Ask AI for Recommendations"),
                  onPressed: _showAIResultDialog,
                )
              ],
            ),
          ),
          Step(
            title: Text("B. Cover Details"),
            content: Column(
              children: [
                CheckboxListTile(title: Text("Accident"), value: true, onChanged: (_) {}),
                CheckboxListTile(title: Text("Disease"), value: false, onChanged: (_) {}),
                CheckboxListTile(title: Text("Natural Hazards"), value: false, onChanged: (_) {}),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.smart_toy),
                  label: Text("Ask AI for Risk Insights"),
                  onPressed: _showAIResultDialog,
                )
              ],
            ),
          ),
          Step(
            title: Text("C. Animals Details"),
            content: Column(
              children: [
                ..._animalList.asMap().entries.map((entry) {
                  int index = entry.key;
                  var animal = entry.value;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("Animal ${index + 1}", style: TextStyle(fontWeight: FontWeight.bold)),
                          TextField(
                            decoration: InputDecoration(labelText: "Breed"),
                            onChanged: (val) => animal["breed"] = val,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: "Age (months)"),
                            onChanged: (val) {
                              animal["age"] = val;
                              _calculateTotal();
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: "Value"),
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              animal["value"] = val;
                              _calculateTotal();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                SizedBox(height: 10),
                Text("Total Value: K$totalValue", style: TextStyle(fontWeight: FontWeight.bold)),
                if (aiSuggestion.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)),
                    child: Text(aiSuggestion, style: TextStyle(color: Colors.green[900])),
                  ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.smart_toy),
                  label: Text("AI Premium Estimate"),
                  onPressed: _showAIResultDialog,
                )
              ],
            ),
          ),
          Step(
            title: Text("D. Farm Details"),
            content: Column(
              children: [
                TextField(decoration: InputDecoration(labelText: "Vaccinations done")),
                TextField(decoration: InputDecoration(labelText: "Tick control method")),
                TextField(decoration: InputDecoration(labelText: "Water Source")),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.analytics),
                  label: Text("AI Farm Risk Report"),
                  onPressed: _showAIResultDialog,
                )
              ],
            ),
          ),
          Step(
            title: Text("E. Find a Vet Near You"),
            content: Column(
              children: [
                Text("Let AI find the best veterinary surgeon near your farm location."),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text("Find Nearby Vet"),
                  onPressed: _showVetFinder,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}