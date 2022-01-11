import 'package:bill_gen/model/waterbillCalculation.dart';
import 'package:bill_gen/screens/GeneratedWaterbill_screen.dart';
import 'package:flutter/material.dart';

class GenerateWaterBill extends StatefulWidget {
  @override
  _GenerateWaterBillState createState() => _GenerateWaterBillState();
}

class _GenerateWaterBillState extends State<GenerateWaterBill> {
  final items = [
    'Domestic',
    'Domestic (Apartements)',
    'Non-Domestic',
    'Industries',
    'Swimming Pools',
  ];
  String value;
  final consumpcontroller = TextEditingController();
  bool _validate = false;
  void _submitData() {
    final maincat = value;
    final consump = double.parse(consumpcontroller.text);
    var obj = WaterBillCalculation();
    var nums = obj.corecalci(consump, maincat);
    Navigator.of(context).pushNamed(
      GeneratedWaterbillScreen.routename,
      arguments: {
        'sanitarycharges': nums['sanitarycharges'].toString(),
        'borecharges': nums['borecharges'].toString(),
        'watercharges': nums['watercharges'].toString(),
        'maincat': nums['maincat'].toString(),
        'consump': nums['consump'].toString(),
        'total': nums['total'].toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  iconSize: 36,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  isExpanded: true,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.value = value),
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Consumption in Liters',
                errorText: _validate
                    ? 'Please enter a Valid Consumption details'
                    : null,
              ),
              controller: consumpcontroller,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    consumpcontroller.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                  if (consumpcontroller.text.isEmpty == false) {
                    _submitData();
                  }
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Generate Bill',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
