import 'package:flutter/material.dart';

class DividerText extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const DividerText({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            const Spacer(),
            if (onPressed != null)
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.edit),
              ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 2,
        ),
      ],
    );
  }
}
