import 'package:bill_gen/model/electriccalculation.dart';
import 'package:bill_gen/screens/GeneratedElecbill_screen.dart';
import 'package:flutter/material.dart';

class GenerateElecBill extends StatefulWidget {
  @override
  _GenerateElecBillState createState() => _GenerateElecBillState();
}

class _GenerateElecBillState extends State<GenerateElecBill> {
  final rrnocontroller = TextEditingController();
  final consumpcontroller = TextEditingController();
  bool _validate = false;
  void _submitData() {
    final rrno = rrnocontroller.text;
    final consump = double.parse(consumpcontroller.text);
    var obj = Calculation(rrno, consump);
    var energycharges = obj.tryfind();
    Navigator.of(context).pushNamed(
      GeneratedbillScreen.routename,
      arguments: {
        'rrno': energycharges['rrno'].toString(),
        'consump': energycharges['consump'].toString(),
        'fixedcharges': energycharges['fixedcharges'].toString(),
        'energycharges': energycharges['energycharges'].toString(),
        'details': energycharges['details'].toString(),
        'total': energycharges['total'].toString(),
        'tariff': energycharges['tariff'].toString(),
        'sancLoad': energycharges['sancLoad'].toString(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            TextField(
              decoration: InputDecoration(
                labelText: 'RR No.',
                errorText: _validate ? 'Please enter a Valid RR NO' : null,
              ),
              controller: rrnocontroller,
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
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                onPressed: () {
                  final validCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
                  setState(() {
                    rrnocontroller.text.isEmpty ||
                            !validCharacters.hasMatch(rrnocontroller.text)
                        ? _validate = true
                        : _validate = false;
                    consumpcontroller.text.isEmpty ||
                            !validCharacters.hasMatch(rrnocontroller.text)
                        ? _validate = true
                        : _validate = false;
                  });
                  if (rrnocontroller.text.isEmpty == false &&
                      consumpcontroller.text.isEmpty == false &&
                      validCharacters.hasMatch(rrnocontroller.text) == true) {
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
