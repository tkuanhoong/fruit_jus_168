import 'package:flutter/material.dart';

class BeverageDescription extends StatelessWidget {
  final bool showFullDescription;

  const BeverageDescription({super.key, required this.showFullDescription});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showFullDescription ? null : 60,
      child: Text(
        showFullDescription
            ? 'Full Beverage Description goes here. Click Read More to see more details.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzsssssssssssssssssssssssssssssssssssssssssssssssssz'
            : 'Short Beverage Description goes here. You can provide more details about the beverage.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz',
        style: TextStyle(
          fontSize: 14,
          color: showFullDescription
              ? Colors.black
              : Colors.black.withOpacity(0.5),
        ),
        textAlign: TextAlign.center,
        maxLines: showFullDescription ? null : 3,
      ),
    );
  }
}
