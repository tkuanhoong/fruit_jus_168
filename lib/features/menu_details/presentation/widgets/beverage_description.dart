import 'package:flutter/material.dart';

class BeverageDescription extends StatelessWidget {
  final bool showFullDescription;
  final String desc;

  const BeverageDescription(
      {super.key, required this.desc, required this.showFullDescription});

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      overflow: showFullDescription ? null : TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 14,
        color:
            showFullDescription ? Colors.black : Colors.black.withOpacity(0.5),
      ),
      textAlign: TextAlign.center,
    );
  }
}
