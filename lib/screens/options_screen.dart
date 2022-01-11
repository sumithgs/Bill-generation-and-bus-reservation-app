import 'package:bill_gen/widget/BusReserv_widget.dart';
import 'package:bill_gen/widget/CustomButton_widget.dart';
import 'package:bill_gen/widget/WaterBill_widget.dart';
import 'package:bill_gen/screens/selection_screen.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButtonWidget(
              ic: Icons.bolt,
              name: 'Electricity Bill',
              func: () =>
                  Navigator.of(context).pushNamed(SelectionScreen.routename),
            ),
            CustomButtonWidget(
              ic: Icons.clean_hands,
              name: 'Water Bill',
              func: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: GenerateWaterBill(),
                  );
                },
              ),
            ),
            CustomButtonWidget(
              ic: Icons.directions_bus,
              name: 'Bus Reservations',
              func: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: BusReservForm(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
