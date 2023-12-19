import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String heading;
  final String subHeading;
  final IconData icon;
  final void Function()? onTap;
  const HomeCard(
      {super.key,
      required this.heading,
      required this.subHeading,
      required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey[200]!, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: Colors.black,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  heading,
                  style:
                      const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Text(
                  subHeading,
                  style: const TextStyle(fontSize: 8),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 10,
            ),
          ],
        ),
      ),
    );
  }
}
