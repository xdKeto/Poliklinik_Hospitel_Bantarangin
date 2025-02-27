import 'package:flutter/material.dart';

class LabelRequired extends StatelessWidget {
  final String text;
  final TextStyle style;
  const LabelRequired({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: style,
        ),
        Text(
          ' *',
          style: TextStyle(
              color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
