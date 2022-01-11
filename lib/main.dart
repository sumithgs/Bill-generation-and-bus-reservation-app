import 'package:bill_gen/provider/busdetail_provider.dart';
import 'package:bill_gen/screens/BusReservPick_screen.dart';
import 'package:bill_gen/screens/BusReservseat_screen.dart';
import 'package:bill_gen/screens/GeneratedElecbill_screen.dart';
import 'package:bill_gen/screens/GeneratedWaterbill_screen.dart';
import 'package:bill_gen/screens/busbooked_screen.dart';
import 'package:bill_gen/screens/options_screen.dart';
import 'package:bill_gen/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusDetailProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: OptionsScreen(),
        routes: {
          SelectionScreen.routename: (context) => SelectionScreen(),
          GeneratedbillScreen.routename: (context) => GeneratedbillScreen(),
          GeneratedWaterbillScreen.routename: (context) =>
              GeneratedWaterbillScreen(),
          BusReservPick.routename: (context) => BusReservPick(),
          BusReservSeat.routename: (context) => BusReservSeat(),
          BusBookScreen.routename: (context) => BusBookScreen(),
        },
      ),
    );
  }
}
