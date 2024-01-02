import 'package:delivery_manager/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class Order_Item extends StatelessWidget {
  final Order order;
  final Function remove;

  Order_Item(this.order, this.remove);

  @override
  Widget build(BuildContext context) {
    bool isdark = Theme.of(context).accentColor == Colors.grey[600];
    return Card(
      color: isdark
          ? Theme.of(context).primaryColor
          : Theme.of(context).accentColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04)
          .add(
        EdgeInsets.only(bottom: 8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor:
                isdark ? Colors.black : Theme.of(context).primaryColor,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${order.price.toStringAsFixed(2)}\$",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(
            order.deliveryman,
            style: TextStyle(color: isdark ? Colors.white : Colors.black),
          ),
          subtitle: Text(
            DateFormat('hh:mm a').format(order.orderdate),
            style: TextStyle(color: isdark ? Colors.white : Colors.black),
          ),
          trailing: IconButton(
            onPressed: () {
              remove(DateFormat('yyyyMMdd').format(order.orderdate), order);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
