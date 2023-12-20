import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String imageUrl;
  const ItemImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 130,
          width: 130,
          decoration: const BoxDecoration(
            color: Color.fromARGB(104, 223, 223, 223),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          height: 130,
          width: 130,
          child: FittedBox(
              fit: BoxFit.fitHeight,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
              )),
        )
      ],
    );
  }
}
