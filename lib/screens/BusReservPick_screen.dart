import 'package:bill_gen/provider/busdetail_provider.dart';
import 'package:bill_gen/screens/BusReservseat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusReservPick extends StatefulWidget {
  static const routename = '/busreservation';

  @override
  _BusReservPickState createState() => _BusReservPickState();
}

class _BusReservPickState extends State<BusReservPick> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BusDetailProvider>(context);
    final busdetail = provider.busdetail;
    final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick a Bus'),
      ),
      body: ListView.builder(
        itemCount: busdetail.length,
        itemBuilder: (context, index) {
          if (routeargs['pfrom'].toUpperCase() ==
                  busdetail[index].from.toUpperCase() &&
              routeargs['tto'].toUpperCase() ==
                  busdetail[index].to.toUpperCase()) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              child: Card(
                elevation: 4,
                shadowColor: Theme.of(context).primaryColor,
                child: ListTile(
                  isThreeLine: true,
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      BusReservSeat.routename,
                      arguments: {
                        'index': index.toString(),
                        'busname': busdetail[index].busname,
                        'bfrom': busdetail[index].from,
                        'bto': busdetail[index].to,
                        'date': routeargs['pdate'],
                        'pname': routeargs['pname'],
                        'busdetail': busdetail[index].maincat,
                        'pricet': busdetail[index].price.toString(),
                      },
                    );
                  },
                  title: Text(
                    busdetail[index].busname,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        busdetail[index].from +
                            '- ${busdetail[index].to}' +
                            ' (' +
                            (busdetail[index].maincat) +
                            ')',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        busdetail[index].ltime,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rs ' + busdetail[index].price.toString() + '/seat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        busdetail[index].timereq,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        busdetail[index].seatsav.toString() +
                            '/' +
                            busdetail[index].totalseat.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
