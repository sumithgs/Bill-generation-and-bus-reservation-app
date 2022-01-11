import 'package:bill_gen/screens/BusReservPick_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusReservForm extends StatefulWidget {
  @override
  _BusReservFormState createState() => _BusReservFormState();
}

class _BusReservFormState extends State<BusReservForm> {
  final fromcontroller = TextEditingController();
  final tocontroller = TextEditingController();
  final namecontroller = TextEditingController();
  bool _validate = false;
  DateTime selectedDate = DateTime.now();

  void _submitData() {
    final from = fromcontroller.text;
    final to = tocontroller.text;
    final name = namecontroller.text;
    final cur = DateFormat('dd-MM-yyyy').format(selectedDate);
    Navigator.of(context).pushNamed(
      BusReservPick.routename,
      arguments: {
        'pfrom': from,
        'tto': to,
        'pname': name,
        'pdate': cur,
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
                labelText: 'Name of Passenger',
                hintText: 'One name is sufficient for multiple seat booking',
                errorText: _validate ? 'Field can\'t be empty' : null,
              ),
              controller: namecontroller,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'From',
                errorText: _validate ? 'Field can\'t be empty' : null,
              ),
              controller: fromcontroller,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'To',
                errorText: _validate ? 'Field can\'t be empty' : null,
              ),
              controller: tocontroller,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () => _selectDate(context),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Pick a date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        namecontroller.text.isEmpty ||
                                fromcontroller.text.isEmpty ||
                                tocontroller.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });
                      if (namecontroller.text.isEmpty == false &&
                          fromcontroller.text.isEmpty == false &&
                          tocontroller.text.isEmpty == false) _submitData();
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
