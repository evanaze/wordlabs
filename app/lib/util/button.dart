import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final icon;
  final String number;

  MyButton({this.icon, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      icon,
      SizedBox(
        height: 10,
      ),
      Text(number),
    ]);
  }
}
