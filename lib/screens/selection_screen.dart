import 'package:bill_gen/widget/CustomButton_widget.dart';
import 'package:bill_gen/widget/ElectricityBill_widget.dart';
import 'package:bill_gen/widget/ManualElecBill_widget.dart';
import 'package:flutter/material.dart';

class SelectionScreen extends StatelessWidget {
  static const routename = '/SelectionScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButtonWidget(
              ic: Icons.home,
              name: 'Check in Database',
              func: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: GenerateElecBill(),
                  );
                },
              ),
            ),
            CustomButtonWidget(
              ic: Icons.store_mall_directory,
              name: 'Do Manual Calculation',
              func: () => showModalBottomSheet(
                context: context,
                builder: (_) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: ManualElecBillWidget(),
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
