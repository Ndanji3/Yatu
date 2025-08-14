import 'package:flutter/material.dart';
import 'package:yatu/main.dart';
import 'button.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Livestock Insurance Policy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
      home: PolicyScreen(),
    );
  }
}

class PolicyScreen extends StatelessWidget {
  final List<Map<String, String>> policySections = [
    {
      "title": "1. Coverage",
      "content":
      "Indemnifies the Insured against loss or damage to livestock due to accident, illness, fire, injury, snake bite, flood, windstorm, and emergency slaughter advised by a qualified vet. Extensions include theft and calving risks (subject to additional premium)."
    },
    {
      "title": "a) Livestock Covered",
      "content":
      "Heifers > 1 year up to pregnancy; Cattle 6 months–9 years; Horses 6 months–14 years; Pigs 2 months–6 years; Goats 2 months–6 years; Sheep 2 months–6 years."
    },
    {
      "title": "b) Livestock Excluded",
      "content":
      "Animals at shows lasting more than one day are not covered."
    },
    {
      "title": "2. Indemnification",
      "content":
      "Valuation is based on animal age and insured value at time of loss. Governmental epidemic payments are deducted. Deductibles: 20% for illness, accident, fire, lightning, windstorm; 5% or 20% for epidemic diseases."
    },
    {
      "title": "3. Exclusions",
      "content":
      "No cover for pre-existing diseases, mastitis, unauthorized slaughter, theft, mysterious disappearance, poor feed, sterility, low milk yield, hereditary defects, abortion, water shortage, nuclear events, treatment costs, war, terrorism, mismanagement, certain age restrictions, nutrient deficiency, tick/worm deaths, third-party liabilities."
    },
    {
      "title": "4. Definitions",
      "content":
      "Loss occurrence: death/slaughter of two or more animals from same cause. Terrorism: acts causing harm with intent to influence government/public. Epidemic: disease affecting a large number of livestock in a region."
    },
    {
      "title": "5. Duties of the Insured",
      "content":
      "Animals must be disease-free at start. Follow vaccination programs, maintain records, inform insurer of herd changes over 5%, call a vet immediately in case of illness/accident, notify insurer within 24 hours."
    },
    {
      "title": "7. General Conditions",
      "content":
      "Covers claim procedures, policy modifications, arbitration rules, cancellation rights, fraud prevention, multiple insurance coordination, salvage handling, and liability time limits."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livestock Policy"),
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: policySections.map((section) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ExpansionTile(
                  tilePadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    section["title"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.green[800],
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        section["content"]!,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

}