import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/routes/app_router.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/core/utility/blocs_wrapper.dart';
import 'package:fruit_jus_168/core/utility/initialize_app_settings.dart';
import 'package:go_router/go_router.dart';
import 'config/theme/app_theme.dart';

Future<void> main() async {
  await initializeAppSettings();
  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocsWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme(),
        title: '168 Jus',
        routerConfig: router,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
          ],
        ),
      ),
    );
  }
}
