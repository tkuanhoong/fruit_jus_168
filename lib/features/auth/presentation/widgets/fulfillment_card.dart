import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/enum/direction.dart';

class FullfillmentCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final Direction direction;
  final void Function()? onTap;
  const FullfillmentCard({
    super.key,
    required this.text,
    required this.imagePath,
    required this.direction,
    this.onTap,
  });

  _buildHorizontalContent(Direction direction) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 200,
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0XFF20941C),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _buildVerticalContent(Direction direction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 200,
          ),
          child: Transform.translate(
            offset: const Offset(0.0, -25.0), // Adjust the Y offset here
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(0.0, -15.0, 0.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0XFF20941C),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ],
            color: Colors.white,
          ),
          child: direction == Direction.horizontal
              ? _buildHorizontalContent(direction)
              : _buildVerticalContent(direction),
        ),
      ),
    );
  }
}
