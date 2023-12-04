import 'package:flutter/material.dart';

class BeverageItem extends StatelessWidget {
  const BeverageItem({
    Key? key,
    required this.getProductName,
    required this.itemCount,
    required this.selectedSize,
    required this.onIceChanged,
    required this.onDecrease,
    required this.onIncrease,
  }) : super(key: key);

  final String getProductName;
  final int itemCount;
  final String selectedSize;
  final ValueChanged<String?> onIceChanged;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Ice Level',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioListTile<String>(
            title: const Text('No Ice'),
            value: 'noIce',
            groupValue: selectedSize,
            onChanged: onIceChanged,
          ),
          RadioListTile<String>(
            title: const Text('Normal Ice'),
            value: 'normalIce',
            groupValue: selectedSize,
            onChanged: onIceChanged,
          ),
          RadioListTile<String>(
            title: const Text('More Ice'),
            value: 'moreIce',
            groupValue: selectedSize,
            onChanged: onIceChanged,
          ),
        ],
      ),
    );
  }
}
