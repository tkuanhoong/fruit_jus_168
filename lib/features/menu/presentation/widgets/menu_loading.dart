import 'package:flutter/material.dart';

class MenuLoadingIndicator extends StatelessWidget {
  const MenuLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(39, 32, 148, 28),
          ),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 250),
                child: const Text(
                  'Welcome to 168 Jus! Please wait while we serve you the best juice in town!\n\n',
                  textAlign: TextAlign.center,
                ),
              ),
              const CircularProgressIndicator(),
            ],
          ),
        )
      ],
    );
  }
}
