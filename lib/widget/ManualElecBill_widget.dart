import 'package:bill_gen/screens/GeneratedElecbill_screen.dart';
import 'package:flutter/material.dart';
import 'package:bill_gen/model/electriccalculation.dart';

class ManualElecBillWidget extends StatefulWidget {
  @override
  _ManualElecBillWidgetState createState() => _ManualElecBillWidgetState();
}

class _ManualElecBillWidgetState extends State<ManualElecBillWidget> {
  final items = [
    '1LT2A1',
    '1LT2A2',
    '1LT2B1',
    '1LT31',
    '1LT32',
    '1LT4B',
  ];
  final maincatcontroller = TextEditingController();
  final sancLoadcontroller = TextEditingController();
  final consumpcontroller = TextEditingController();
  String value;
  bool _validate = false;
  void _submitData() {
    final maincat = maincatcontroller.text;
    final tariff = value;
    final sancLoad = double.parse(sancLoadcontroller.text);
    final consump = double.parse(consumpcontroller.text);
    var obj = CoreCalculation();
    var energycharges = obj.coreCalcu(
      maincat.toUpperCase(),
      tariff.toUpperCase(),
      sancLoad,
      consump,
    );

    Navigator.of(context).pushNamed(
      GeneratedbillScreen.routename,
      arguments: {
        'rrno': '_',
        'consump': energycharges['consump'].toString(),
        'fixedcharges': energycharges['fixedcharges'].toString(),
        'energycharges': energycharges['energycharges'].toString(),
        'details': '_',
        'total': energycharges['total'].toString(),
        'tariff': energycharges['tariff'].toString(),
        'sancLoad': energycharges['sancLoad'].toString(),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Main Category: ',
                  hintText: 'LOWT or HIGHT',
                  errorText:
                      _validate ? 'Please enter a Valid Main Category' : null,
                ),
                controller: maincatcontroller,
              ),
            ),
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
                labelText: 'Consumption in KWH',
                errorText: _validate
                    ? 'Please enter a Valid Consumption details'
                    : null,
              ),
              controller: consumpcontroller,
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Sanc Load: ',
                errorText: _validate ? 'Please enter a Valid Sanc Load' : null,
              ),
              controller: sancLoadcontroller,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                onPressed: () {
                  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
                  setState(() {
                    maincatcontroller.text.isEmpty ||
                            !validCharacters.hasMatch(maincatcontroller.text) ||
                            consumpcontroller.text.isEmpty ||
                            sancLoadcontroller.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                  if (maincatcontroller.text.isEmpty == false &&
                      consumpcontroller.text.isEmpty == false &&
                      validCharacters.hasMatch(maincatcontroller.text) ==
                          true) {
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
