import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fruit_jus_168/config/stripe/stripe_constants.dart';
import 'package:fruit_jus_168/core/utility/app_bloc_observer.dart';
import 'package:fruit_jus_168/firebase_options.dart';
import 'package:fruit_jus_168/core/utility/injection_container.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

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
  // stripe payment
  Stripe.publishableKey = STRIPE_PUBLIC_KEY;
  // load env
  await dotenv.load(fileName: "assets/.env");
  // initialize the dependencies (services locator)
  await initializeDependencies();
}
