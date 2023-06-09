import 'package:flutter/material.dart';

import '../constants/Colors.dart';

class Line extends StatelessWidget {
  const Line({
    super.key,
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                height: 1,
                decoration:
                BoxDecoration(color: primaryColor))),
        const SizedBox(width: 10,),
        Text(
          text
        ),
        const SizedBox(width: 10,),
        Expanded(
            child: Container(
                height: 1,
                decoration:
                BoxDecoration(color: primaryColor))),
      ],
    );
  }
}