import 'package:flutter/material.dart';
import 'package:fruit_jus_168/config/theme/app_colors.dart';

ThemeData theme() {
  return ThemeData(
    brightness: Brightness.light,
    // useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Poppins',
    // text theme defines text styling
    textTheme: textTheme(),
    // color scheme defines the colors
    colorScheme: colorScheme(),
    elevatedButtonTheme: elevatedButtonThemeData(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black87),
    titleMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
  );
}

ElevatedButtonThemeData elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    ),
  );
}

ColorScheme colorScheme() {
  return ColorScheme.fromSwatch(
      primarySwatch: generateMaterialColorFromColor(AppColors.primaryColor));
}

MaterialColor generateMaterialColorFromColor(Color color) {
  return MaterialColor(color.value, {
    50: Color.fromRGBO(color.red, color.green, color.blue, 0.1),
    100: Color.fromRGBO(color.red, color.green, color.blue, 0.2),
    200: Color.fromRGBO(color.red, color.green, color.blue, 0.3),
    300: Color.fromRGBO(color.red, color.green, color.blue, 0.4),
    400: Color.fromRGBO(color.red, color.green, color.blue, 0.5),
    500: Color.fromRGBO(color.red, color.green, color.blue, 0.6),
    600: Color.fromRGBO(color.red, color.green, color.blue, 0.7),
    700: Color.fromRGBO(color.red, color.green, color.blue, 0.8),
    800: Color.fromRGBO(color.red, color.green, color.blue, 0.9),
    900: Color.fromRGBO(color.red, color.green, color.blue, 1.0),
  });
}
