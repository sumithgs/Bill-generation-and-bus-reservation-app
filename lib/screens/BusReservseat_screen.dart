import 'package:bill_gen/provider/busdetail_provider.dart';
import 'package:bill_gen/screens/busbooked_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BusReservSeat extends StatefulWidget {
  static const routename = '/busreservseat';
  @override
  _BusReservSeatState createState() => _BusReservSeatState();
}

class _BusReservSeatState extends State<BusReservSeat> {
  List<bool> isSelected = List.generate(36, (_) => false);
  var bookedseats = [];
  var map = Map();
  var v = 0;
  List<int> realseats = [];
  List<Widget> text = List.generate(
    36,
    (index) => Center(
      child: Icon(
        Icons.event_seat,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<BusDetailProvider>(context, listen: false);
    final busdetail = prov.busdetail;
    final routeargs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    var counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select your seat',
        ),
        actions: [
          FlatButton(
            child: Text(
              'Book',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              bookedseats.forEach((element) {
                if (!map.containsKey(element)) {
                  map[element] = 1;
                } else {
                  map[element] += 1;
                }
              });
              map.forEach((k, v) {
                if ((v % 2) != 0) {
                  realseats.add(k);
                }
              });
              realseats.sort();
              Navigator.of(context).pushReplacementNamed(
                BusBookScreen.routename,
                arguments: {
                  'busname': routeargs['busname'],
                  'bfrom': routeargs['bfrom'],
                  'bto': routeargs['bto'],
                  'pname': routeargs['pname'],
                  'busdate': routeargs['date'],
                  'busdetail': routeargs['busdetail'],
                  'bookedseats': realseats.toString(),
                  'noseats': realseats.length.toString(),
                  'pricet': routeargs['pricet'],
                  'total':
                      (double.parse(routeargs['pricet']) * realseats.length)
                          .toString(),
                },
              );

              prov.updateSeats(
                  busdetail[int.parse(routeargs['index'])],
                  (busdetail[int.parse(routeargs['index'])].seatsav -
                      realseats.length),
                  realseats);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'This side is front',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      children: [
                        Spacer(),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(
                              color: Colors.pink,
                              width: 2,
                            ),
                          ),
                        ),
                        Spacer(flex: 2),
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            border: Border.all(
                              color: Colors.pink,
                              width: 2,
                            ),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                      ),
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 1.4,
                        children: text.map(
                          (widget) {
                            final index = ++counter - 1;
                            bool istrue = false;
                            busdetail[int.parse(routeargs['index'])]
                                .reserv
                                .forEach((element) {
                              if (element == index + 1) {
                                istrue = true;
                              }
                            });
                            return istrue
                                ? Icon(
                                    Icons.event_seat_outlined,
                                  )
                                : ToggleButtons(
                                    selectedColor:
                                        Theme.of(context).primaryColor,
                                    fillColor: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0),
                                    //selectedBorderColor: Colors.green,
                                    renderBorder: false,
                                    highlightColor: Colors.amber,
                                    color: Colors.black,
                                    isSelected: [isSelected[index]],
                                    onPressed: (_) {
                                      final isOneSelecteed = isSelected
                                              .where((element) => element)
                                              .length ==
                                          1;
                                      if (isOneSelecteed && isSelected[index])
                                        return;
                                      setState(() {
                                        isSelected[index] = !isSelected[index];
                                        bookedseats.add(index + 1);
                                      });
                                    },
                                    children: [
                                      Container(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    MediaQuery.of(context)
                                                        .padding
                                                        .left -
                                                    MediaQuery.of(context)
                                                        .padding
                                                        .right) *
                                                0.193,
                                        child: widget,
                                      ),
                                    ],
                                  );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.event_seat,
                    ),
                    Text(
                      'Available',
                    ),
                    Icon(
                      Icons.event_seat_outlined,
                    ),
                    Text(
                      'Reserved',
                    ),
                    Icon(
                      Icons.event_seat,
                      color: Theme.of(context).primaryColor,
                    ),
                    Text(
                      'Selected',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
GridView.count(
          mainAxisSpacing: 3,
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          children: text.map(
            (widget) {
              final index = ++counter - 1;
              return ToggleButtons(
                selectedColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor.withOpacity(0),
                //selectedBorderColor: Colors.green,
                renderBorder: false,
                highlightColor: Colors.amber,
                color: Colors.black,
                isSelected: [isSelected[index]],
                onPressed: (_) {
                  final isOneSelecteed =
                      isSelected.where((element) => element).length == 1;
                  if (isOneSelecteed && isSelected[index]) return;
                  setState(() {
                    isSelected[index] = !isSelected[index];
                    bookedseats.add(index + 1);
                  });
                  print(index + 1);
                },
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.left -
                            MediaQuery.of(context).padding.right) *
                        0.2,
                    child: widget,
                  ),
                ],
              );
            },
          ).toList(),
        ),
busdetail[int.parse(routeargs['index'])]
                  .reserv
                  .forEach((element) {
                if (element == index) {
                  print(index);
                  return Text('d');
                }
              });


 */
/*
ToggleButtons(
            selectedColor: Colors.white,
            color: Colors.black,
            fillColor: Colors.green,
            selectedBorderColor: Colors.green,
            children: [ Text('1'),
          Text('2'),
          Text('3'),
          Text('4'),
          Text('5'),
          Text('6'),
          Text('7'),
          Text('8'),
          Text('9'),],
            isSelected: [isSelected[index]],
            onPressed: (int index) {
              setState(() {
                isSelected[index] = !isSelected[index];
              });
            },
          )
          
          GridView.builder(
          itemCount: isSelected.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) => Container(
            child: Text(
              '${index + 1}',
            ),
          ),
        )
          */

/*
              if (busdetail[int.parse(routeargs['index'])].reserv.length > 0 &&
                  busdetail[int.parse(routeargs['index'])]
                      .reserv
                      .contains(v++)) {
                return Container(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Center(
                    child: Icon(
                      Icons.event_seat_outlined,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),
                );
              }
              busdetail[int.parse(routeargs['index'])]
                  .reserv
                  .forEach((element) {
                return Icon(
                  Icons.event_seat_outlined,
                  color: Theme.of(context).canvasColor,
                );
              });*/
