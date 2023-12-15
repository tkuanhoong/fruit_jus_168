import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget menu_loading(BuildContext context) {
  return Center(
    child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        Container(
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
    ),
  );
}
