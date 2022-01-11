import 'package:flutter/material.dart';
import 'package:bill_gen/model/Busdetails.dart';

class BusDetailProvider extends ChangeNotifier {
  List<BusDetails> _busdetail = [
    BusDetails(
      busname: 'Sanjay Travels',
      price: 800,
      maincat: 'Ac',
      ltime: '5:30 am',
      timereq: '3hr 18min',
      from: 'Bangalore',
      to: 'Mysore',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'Pooja Travels',
      price: 400,
      maincat: 'Non-Ac',
      ltime: '5:30 am',
      timereq: '3hr 18min',
      from: 'Bangalore',
      to: 'Mysore',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'Poornima Travels',
      price: 400,
      maincat: 'Non-AC',
      ltime: '5:00 am',
      timereq: '7hr 30min',
      from: 'Bangalore',
      to: 'Mangalore',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'Vinayaka Travels',
      price: 500,
      maincat: 'AC',
      ltime: '6:00 am',
      timereq: '7hr 30min',
      from: 'Bangalore',
      to: 'Mangalore',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'Veer Travels',
      price: 400,
      maincat: 'Non-AC',
      ltime: '7:00 am',
      timereq: '6hr 30min',
      from: 'Bangalore',
      to: 'Hubli',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'Dutta Travels',
      price: 500,
      maincat: 'AC',
      ltime: '5:00 am',
      timereq: '6hr 30min',
      from: 'Bangalore',
      to: 'Hubli',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'S.S Travels',
      price: 800,
      maincat: 'Non-AC',
      ltime: '6:00 am',
      timereq: '10hr 30min',
      from: 'Bangalore',
      to: 'Goa',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
    BusDetails(
      busname: 'V.V Travels',
      price: 950,
      maincat: 'AC',
      ltime: '6:00 am',
      timereq: '10hr 30min',
      from: 'Bangalore',
      to: 'Goa',
      seatsav: 35,
      totalseat: 35,
      reserv: [],
    ),
  ];
  List<BusDetails> get busdetail => _busdetail.toList();
  updateSeats(BusDetails busdetail, int seata, List reser) {
    busdetail.seatsav = seata;
    busdetail.reserv.addAll(reser);
    notifyListeners();
  }
}
