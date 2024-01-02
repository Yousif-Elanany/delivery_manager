import 'package:flutter/material.dart';

class dropdowndecriptiontitle extends StatelessWidget {
  String Title;
  dropdowndecriptiontitle(this.Title);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Text(
          Title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ));
  }
}
