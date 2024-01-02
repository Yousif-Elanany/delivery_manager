import 'package:flutter/material.dart';

class chartbar extends StatelessWidget {
  final Color color;
  final double height;
  final String name;
  final int numberoforder;
  chartbar(
      {@required this.color,
      @required this.height,
      @required this.numberoforder,
      @required this.name});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      textStyle: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12)),
      message: "name:$name\n #orders: $numberoforder",
      child: Container(
        width: 20,
        height: height,
        color: color,
      ),
    );
  }
}
