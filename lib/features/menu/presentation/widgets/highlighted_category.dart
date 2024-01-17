import 'package:flutter/material.dart';

BoxDecoration highlighted_category() {
  return const BoxDecoration(
    border: Border(
      left: BorderSide(
        color: Color(0XFF20941C),
        width: 3,
      ),
    ),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color.fromARGB(62, 32, 148, 28),
        Color.fromARGB(15, 214, 234, 214),
        Colors.white,
      ],
      stops: [0.1, 0.5, 0.8],
    ),
  );
}
