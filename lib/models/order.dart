import 'package:flutter/foundation.dart';

class Order {
  static int _counter = 0;
  double price;
  String deliveryman;
  DateTime orderdate;
  int id;

  Order(
      {@required this.deliveryman,
      @required this.orderdate,
      @required this.price}) {
    // _counter++;
    //id = _counter;
    id = ++_counter;
  }
}
