import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/themeController.dart';
import 'home/home.dart';
import 'style/themeStyle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeController = ThemeController(prefs);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return ThemeControllerProvider(
          controller: themeController,
          child: MaterialApp(
            title: "Simple Choice",
            theme: _buildCurrentTheme(themeController),
            debugShowCheckedModeBanner: false,
            home: Home(),
          ),
        );
      }));
}

ThemeData _buildCurrentTheme(themeController) {
  return ThemeData(
    brightness: (themeController.currentTheme == "dark")
        ? Brightness.dark
        : Brightness.light,
    primaryColor: primaryColor,
    splashColor: (themeController.currentTheme == "dark")
        ? Colors.black45
        : primaryColor,
    platform: TargetPlatform.iOS,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    buttonTheme: ButtonThemeData(buttonColor: primaryColor),
    fontFamily: 'DroidSans',
    textTheme: TextTheme(
      headline5: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, fontFamily: 'DroidSans'),
      headline6: TextStyle(
          fontSize: 24.0, fontStyle: FontStyle.normal, fontFamily: 'DroidSans'),
      bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'DroidSans'),
    ),
  );
}
