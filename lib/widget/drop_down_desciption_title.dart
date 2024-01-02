import 'package:flutter/material.dart';

class dropdowndecriptiontitle extends StatelessWidget {
  String title;
  dropdowndecriptiontitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ));
  }
}
