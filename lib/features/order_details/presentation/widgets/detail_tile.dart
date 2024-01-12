import 'package:flutter/material.dart';

class DetailTile extends StatelessWidget {
  final String title;
  final String value;
  final bool? isId;
  const DetailTile({
    super.key,
    required this.title,
    required this.value,
    this.isId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
              decoration: isId == true ? TextDecoration.underline : null),
        ),
      ],
    );
  }
}
