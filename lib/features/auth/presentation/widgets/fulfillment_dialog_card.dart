import 'package:flutter/material.dart';

class FulfillmentDialogCard extends StatelessWidget {
  final String text;
  final String imagePath;
  final void Function()? onTap;
  const FulfillmentDialogCard({
    super.key,
    required this.text,
    required this.imagePath,
    this.onTap,
  });

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                width: 100,
                height: 100,
                imagePath,
                fit: BoxFit.cover,
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
          ),
        ),
      ),
    );
  }
}
