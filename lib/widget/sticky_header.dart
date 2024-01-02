import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stickyheader extends StatelessWidget {
  final String date;

  stickyheader(@required this.date);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04)
          .add(EdgeInsets.only(bottom: 8)),
      color: Theme.of(context).primaryColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: Text(
          date,
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
