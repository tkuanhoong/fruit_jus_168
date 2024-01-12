import 'package:flutter/material.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 0.5,
              width: 15,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey,
                color: Color.fromARGB(255, 81, 81, 81),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
