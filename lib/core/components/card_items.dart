import 'package:flutter/material.dart';

class CardStack extends StatelessWidget {
  const CardStack({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          child: CardItem(
            imagePath:
                'assets/images/invitefriend.jpg', // Replace with your image path
            title: 'More shares, more discount',
          ),
        ),
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final String imagePath;
  final String title;

  const CardItem({super.key, required this.imagePath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 400,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Share your referral code now for more discount',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
