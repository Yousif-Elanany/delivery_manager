import 'package:flutter/material.dart';

class HeroItem extends StatelessWidget {
  final String name;
  final Color color;
  HeroItem(
    this.name,
    this.color,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          color: color,
        ),
        Text(name)
      ],
    );
  }
}
