import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/core/utility/app_bloc_observer.dart';
import 'package:fruit_jus_168/firebase_options.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';

Future<void> initializeAppSettings() async {
  // ensure that the flutter tree is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // ensure that the firebase app is initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // bloc observer for better debugging the blocs
  Bloc.observer = const AppBlocObserver();
  // fix the device's orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // initialize the dependencies (services locator)
  await initializeDependencies();
}
