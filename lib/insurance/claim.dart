import 'dart:convert';

import 'package:flutter/material.dart';


class Claim extends StatefulWidget {
  const Claim ({super.key});

  @override
  State<Claim> createState() => _ClaimState();
}

class _ClaimState extends State<Claim> {
  final _formKey = GlobalKey<FormState>();

  // Contact / Policy details
  final insuredNameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final faxCtrl = TextEditingController();
  final policyNumberCtrl = TextEditingController();
  DateTime? lastPremiumPaidDate;

  // Loss location & timing
  final lossPremisesAddressCtrl = TextEditingController();
  DateTime? dateOfLoss;
  TimeOfDay? timeOfLoss;

  // Claim details
  final natureOfClaimCtrl = TextEditingController();
  final lossHowOccurredCtrl = TextEditingController();

  // Loss discovery
  DateTime? lastSeenDate;
  TimeOfDay? lastSeenTime;
  DateTime? lossDiscoveredDate;
  final lossDiscoveredByCtrl = TextEditingController();

  // Police reporting
  bool policeInformed = false;
  final policeStationCtrl = TextEditingController();
  DateTime? policeReportDate;
  TimeOfDay? policeReportTime;
  final policeReporterNameAddressCtrl = TextEditingController();

  // Repair info
  bool canBeRepaired = false;

  // Declaration & signature
  DateTime? declarationDate;
  final signatureNameCtrl = TextEditingController();

  // Dynamic table: Declaration of Property Lost or Damaged
  final List<ClaimItem> items = [
    ClaimItem(),
  ];

  @override
  void dispose() {
    insuredNameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    faxCtrl.dispose();
    policyNumberCtrl.dispose();
    lossPremisesAddressCtrl.dispose();
    natureOfClaimCtrl.dispose();
    lossHowOccurredCtrl.dispose();
    lossDiscoveredByCtrl.dispose();
    policeStationCtrl.dispose();
    policeReporterNameAddressCtrl.dispose();
    signatureNameCtrl.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(BuildContext context, {DateTime? initial}) async {
    final now = DateTime.now();
    final base = initial ?? now;
    return showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
      initialDate: base,
    );
  }

  Future<TimeOfDay?> _pickTime(BuildContext context,
      {TimeOfDay? initial}) async {
    return showTimePicker(
      context: context,
      initialTime: initial ?? TimeOfDay.now(),
    );
  }

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in red')),
      );
      return;
    }
    // Convert form to model -> JSON
    final data = ClaimFormData(
      insuredName: insuredNameCtrl.text.trim(),
      phoneNumber: phoneCtrl.text.trim(),
      address: addressCtrl.text.trim(),
      facsimileNumber: faxCtrl.text.trim(),
      policyNumber: policyNumberCtrl.text.trim(),
      dateOfLastPremiumPaid: lastPremiumPaidDate?.toIso8601String(),
      premisesAddressWhereLossSustained: lossPremisesAddressCtrl.text.trim(),
      dateOfLoss: dateOfLoss?.toIso8601String(),
      timeOfLoss: timeOfLoss?.format(context),
      natureOfClaim: natureOfClaimCtrl.text.trim(),
      howLossOccurred: lossHowOccurredCtrl.text.trim(),
      lastSeenDate: lastSeenDate?.toIso8601String(),
      lastSeenTime: lastSeenTime?.format(context),
      lossDiscoveredDate: lossDiscoveredDate?.toIso8601String(),
      lossDiscoveredBy: lossDiscoveredByCtrl.text.trim(),
      policeInformed: policeInformed,
      policeStation: policeStationCtrl.text.trim(),
      policeReportDate: policeReportDate?.toIso8601String(),
      policeReportTime: policeReportTime?.format(context),
      policeReporterNameAndAddress: policeReporterNameAddressCtrl.text.trim(),
      canArticleBeRepaired: canBeRepaired,
      declarationDate: declarationDate?.toIso8601String(),
      signatureName: signatureNameCtrl.text.trim(),
      items: items
          .where((e) => e.anyFilled)
          .map((e) => e.toJson())
          .toList(growable: false),
    );

    final jsonStr = const JsonEncoder.withIndent('  ').convert(data.toJson());
    // For demo: show in a dialog. In a real app, POST this JSON to your API.
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Form JSON'),
        content: SingleChildScrollView(
          child: Text(jsonStr),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required void Function(DateTime?) onChanged,
    bool requiredField = false,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await _pickDate(context, initial: value);
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          errorText: requiredField && value == null ? 'Required' : null,
        ),
        child: Text(
          value == null ? 'Tap to select' : _fmtDate(value),
        ),
      ),
    );
  }

  Widget _timeField({
    required String label,
    required TimeOfDay? value,
    required void Function(TimeOfDay?) onChanged,
    bool requiredField = false,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await _pickTime(context, initial: value);
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          errorText: requiredField && value == null ? 'Required' : null,
        ),
        child: Text(
          value == null ? 'Tap to select' : value.format(context),
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Miscellaneous Claim Form'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _section(
                  'Insured & Policy Details',
                  children: [
                    _row([
                      _text('Name of Insured', insuredNameCtrl, validator: _required),
                    ]),
                      _row([
                        _text('Phone Number', phoneCtrl, keyboardType: TextInputType.phone, validator: _required),
                    ]),
                    _row([
                      _text('Address', addressCtrl, maxLines: 2, validator: _required),
                    ]),
                    _row([
                      _text('Facsimile Number', faxCtrl, keyboardType: TextInputType.phone),
                    ]),
                    _row([
                      _text('Policy Number', policyNumberCtrl, validator: _required),
                    ]),
                      _row([
                      _dateField(
                        label: 'Date of Last Premium Paid',
                        value: lastPremiumPaidDate,
                        onChanged: (v) => setState(() => lastPremiumPaidDate = v),
                      ),
                    ]),
                  ],
                ),
                _section(
                  'Location & Time of Loss',
                  children: [
                    _text('Address of Premises Where Loss Was Sustained', lossPremisesAddressCtrl, maxLines: 2, validator: _required),
                    _row([
                      _dateField(
                        label: 'Date of Loss',
                        value: dateOfLoss,
                        onChanged: (v) => setState(() => dateOfLoss = v),
                        requiredField: true,
                      ),
                      ]),
                    _row([
                      _timeField(
                        label: 'Time of Loss',
                        value: timeOfLoss,
                        onChanged: (v) => setState(() => timeOfLoss = v),
                        requiredField: true,
                      ),
                    ]),
                  ],
                ),
                _section(
                  'Claim Details',
                  children: [
                    _text('Nature of Claim', natureOfClaimCtrl, maxLines: 2, validator: _required),
                    _text('Full Details of How the Loss or Damage Occurred', lossHowOccurredCtrl, maxLines: 6, validator: _required),
                  ],
                ),
                _section(
                  'Loss Discovery',
                  children: [
                    _row([
                      _dateField(
                        label: 'Date Last Seen (for loss cases)',
                        value: lastSeenDate,
                        onChanged: (v) => setState(() => lastSeenDate = v),
                      ),
                      ]),
                    _row([
                      _timeField(
                        label: 'Time Last Seen',
                        value: lastSeenTime,
                        onChanged: (v) => setState(() => lastSeenTime = v),
                      ),
                    ]),
                    _row([
                      _dateField(
                        label: 'Date Loss Discovered',
                        value: lossDiscoveredDate,
                        onChanged: (v) => setState(() => lossDiscoveredDate = v),
                      ),
                      ]),
                    _row([
                      _text('Loss Discovered By (Name)', lossDiscoveredByCtrl),
                    ]),
                  ],
                ),
                _section(
                  'Police Report / Other Enquiries',
                  children: [
                    _switch(
                      'Have police been informed (or other enquiries made)?',
                      policeInformed,
                          (v) => setState(() => policeInformed = v),
                    ),
                    if (policeInformed) ...[
                      _text('Police Station Reported To', policeStationCtrl, validator: _required),
                      _row([
                        _dateField(
                          label: 'Police Report Date',
                          value: policeReportDate,
                          onChanged: (v) => setState(() => policeReportDate = v),
                          requiredField: true,
                        ),
                        _timeField(
                          label: 'Police Report Time',
                          value: policeReportTime,
                          onChanged: (v) => setState(() => policeReportTime = v),
                          requiredField: true,
                        ),
                      ]),
                      _text('Name & Address of Person Who Made Report', policeReporterNameAddressCtrl, maxLines: 2, validator: _required),
                    ],
                  ],
                ),
                _section(
                  'Repair Information',
                  children: [
                    _switch(
                      'In the event of damage can article(s) be repaired?',
                      canBeRepaired,
                          (v) => setState(() => canBeRepaired = v),
                    ),
                    const Text(
                      'If yes, attach/submit repairer’s estimate(s).',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
                _section(
                  'Declaration of Property Lost or Damaged (add items as needed)',
                  children: [
                    _itemsTable(),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        spacing: 8,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => setState(() => items.add(ClaimItem())),
                            icon: const Icon(Icons.add),
                            label: const Text('Add Item'),
                          ),
                          if (items.length > 1)
                            ElevatedButton.icon(
                              onPressed: () => setState(() {
                                if (items.isNotEmpty) items.removeLast();
                              }),
                              icon: const Icon(Icons.remove),
                              label: const Text('Remove Last'),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                _section(
                  'Declaration & Signature',
                  children: [
                    const Text(
                      'I/We hereby declare and warrant that all the information provided is true and correct. False or withheld information may lead to repudiation of the claim.',
                      textAlign: TextAlign.start,
                    ),
                    _row([
                      _dateField(
                        label: 'Date',
                        value: declarationDate,
                        onChanged: (v) => setState(() => declarationDate = v),
                        requiredField: true,
                      ),
                      _text('Signature (Type Full Name)', signatureNameCtrl, validator: _required),
                    ]),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: _submit,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- UI Helpers ----------

  Widget _section(String title, {required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(height: 10),
          ...children.map((w) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: w,
          )),
        ],
      ),
    );
  }

  Widget _row(List<Widget> children) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;
        if (isWide) {
          return Row(
            children: children
                .map((w) => Expanded(child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: w,
            )))
                .toList()
              ..last = Expanded(child: children.last),
          );
        }
        return Column(children: children);
      },
    );
  }

  Widget _text(
      String label,
      TextEditingController controller, {
        int maxLines = 1,
        String? Function(String?)? validator,
        TextInputType? keyboardType,
      }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  Widget _switch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _itemsTable() {
    final headerStyle = Theme.of(context).textTheme.labelLarge;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 900),
            child: Table(
              columnWidths: const {
                0: FixedColumnWidth(220), // Property Lost or Damaged
                1: FixedColumnWidth(180), // Where Purchased/Acquired
                2: FixedColumnWidth(140), // Date Purchased/Acquired
                3: FixedColumnWidth(150), // Replacement Cost Price
                4: FixedColumnWidth(150), // % Deduction for Depreciation
                5: FixedColumnWidth(150), // Net amount Being Claimed
                6: FixedColumnWidth(220), // Remarks
                7: FixedColumnWidth(60),  // Delete
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                  children: [
                    Padding(padding: const EdgeInsets.all(8), child: Text('Property Lost or Damaged', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('Where Purchased or Acquired', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('Date Purchased/Acquired', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('Replacement Cost Price', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('% Deduction for Depreciation', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('Net Amount Being Claimed', style: headerStyle)),
                    Padding(padding: const EdgeInsets.all(8), child: Text('Remarks (if any)', style: headerStyle)),
                    const SizedBox(),
                  ],
                ),
                ...List.generate(items.length, (i) {
                  final item = items[i];
                  return TableRow(
                    children: [
                      _cell(TextFormField(
                        controller: item.propertyCtrl,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Item/Description'),
                        validator: (v) {
                          // validate at least property OR amount to prevent empty rows
                          if (!item.anyFilled) return 'Fill or remove this row';
                          return null;
                        },
                      )),
                      _cell(TextFormField(
                        controller: item.wherePurchasedCtrl,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Store/Seller'),
                      )),
                      _cell(
                        _miniDateField(
                          value: item.datePurchased,
                          onPick: (d) => setState(() => item.datePurchased = d),
                        ),
                      ),
                      _cell(TextFormField(
                        controller: item.replacementCostCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. 1200.00'),
                      )),
                      _cell(TextFormField(
                        controller: item.depreciationPctCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. 10'),
                      )),
                      _cell(TextFormField(
                        controller: item.netAmountCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'e.g. 1080.00'),
                      )),
                      _cell(TextFormField(
                        controller: item.remarksCtrl,
                        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Optional'),
                      )),
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: IconButton(
                          tooltip: 'Delete row',
                          onPressed: items.length == 1
                              ? null
                              : () => setState(() {
                            items.removeAt(i);
                          }),
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniDateField({required DateTime? value, required ValueChanged<DateTime?> onPick}) {
    return InkWell(
      onTap: () async {
        final picked = await _pickDate(context, initial: value);
        onPick(picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        child: Text(value == null ? 'Pick date' : _fmtDate(value)),
      ),
    );
  }

  Widget _cell(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: child,
    );
  }
}

// ---------- Data Model ----------

class ClaimItem {
  final TextEditingController propertyCtrl = TextEditingController();
  final TextEditingController wherePurchasedCtrl = TextEditingController();
  DateTime? datePurchased;
  final TextEditingController replacementCostCtrl = TextEditingController();
  final TextEditingController depreciationPctCtrl = TextEditingController();
  final TextEditingController netAmountCtrl = TextEditingController();
  final TextEditingController remarksCtrl = TextEditingController();

  bool get anyFilled =>
      propertyCtrl.text.trim().isNotEmpty ||
          wherePurchasedCtrl.text.trim().isNotEmpty ||
          datePurchased != null ||
          replacementCostCtrl.text.trim().isNotEmpty ||
          depreciationPctCtrl.text.trim().isNotEmpty ||
          netAmountCtrl.text.trim().isNotEmpty ||
          remarksCtrl.text.trim().isNotEmpty;

  Map<String, dynamic> toJson() => {
    'propertyLostOrDamaged': propertyCtrl.text.trim(),
    'wherePurchasedOrAcquired': wherePurchasedCtrl.text.trim(),
    'datePurchasedOrAcquired': datePurchased?.toIso8601String(),
    'replacementCostPrice': _numOrNull(replacementCostCtrl.text),
    'depreciationPercent': _numOrNull(depreciationPctCtrl.text),
    'netAmountBeingClaimed': _numOrNull(netAmountCtrl.text),
    'remarks': remarksCtrl.text.trim(),
  };

  num? _numOrNull(String s) {
    final t = s.trim();
    if (t.isEmpty) return null;
    return num.tryParse(t);
    // Leave null if cannot parse.
  }
}

class ClaimFormData {
  final String insuredName;
  final String phoneNumber;
  final String address;
  final String facsimileNumber;
  final String policyNumber;
  final String? dateOfLastPremiumPaid;

  final String premisesAddressWhereLossSustained;
  final String? dateOfLoss;
  final String? timeOfLoss;

  final String natureOfClaim;
  final String howLossOccurred;

  final String? lastSeenDate;
  final String? lastSeenTime;

  final String? lossDiscoveredDate;
  final String lossDiscoveredBy;

  final bool policeInformed;
  final String policeStation;
  final String? policeReportDate;
  final String? policeReportTime;
  final String policeReporterNameAndAddress;

  final bool canArticleBeRepaired;

  final String? declarationDate;
  final String signatureName;

  final List<Map<String, dynamic>> items;

  ClaimFormData({
    required this.insuredName,
    required this.phoneNumber,
    required this.address,
    required this.facsimileNumber,
    required this.policyNumber,
    required this.dateOfLastPremiumPaid,
    required this.premisesAddressWhereLossSustained,
    required this.dateOfLoss,
    required this.timeOfLoss,
    required this.natureOfClaim,
    required this.howLossOccurred,
    required this.lastSeenDate,
    required this.lastSeenTime,
    required this.lossDiscoveredDate,
    required this.lossDiscoveredBy,
    required this.policeInformed,
    required this.policeStation,
    required this.policeReportDate,
    required this.policeReportTime,
    required this.policeReporterNameAndAddress,
    required this.canArticleBeRepaired,
    required this.declarationDate,
    required this.signatureName,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'insuredName': insuredName,
    'phoneNumber': phoneNumber,
    'address': address,
    'facsimileNumber': facsimileNumber,
    'policyNumber': policyNumber,
    'dateOfLastPremiumPaid': dateOfLastPremiumPaid,
    'premisesAddressWhereLossSustained': premisesAddressWhereLossSustained,
    'dateOfLoss': dateOfLoss,
    'timeOfLoss': timeOfLoss,
    'natureOfClaim': natureOfClaim,
    'howLossOccurred': howLossOccurred,
    'lastSeenDate': lastSeenDate,
    'lastSeenTime': lastSeenTime,
    'lossDiscoveredDate': lossDiscoveredDate,
    'lossDiscoveredBy': lossDiscoveredBy,
    'policeInformed': policeInformed,
    'policeStation': policeStation,
    'policeReportDate': policeReportDate,
    'policeReportTime': policeReportTime,
    'policeReporterNameAndAddress': policeReporterNameAndAddress,
    'canArticleBeRepaired': canArticleBeRepaired,
    'declarationDate': declarationDate,
    'signatureName': signatureName,
    'items': items,
  };
}