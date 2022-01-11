import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final IconData ic;
  final String name;
  final Function func;
  CustomButtonWidget({this.ic, this.name, this.func});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: 250,
      child: RaisedButton.icon(
        icon: Icon(
          ic,
          color: Theme.of(context).canvasColor,
          size: 50,
        ),
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.amber,
        onPressed: func,
        label: Text(
          name,
          style: TextStyle(
            color: Theme.of(context).canvasColor,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
