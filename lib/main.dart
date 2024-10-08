import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/utils/constants.dart';
import 'package:getx_todo/utils/firebase_options.dart';
import 'pages/home.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: appTheme,
      home: Home(),
    );
  }

  final ThemeData appTheme = ThemeData(
    primaryColor: almond,
    hintColor: mustard,
    fontFamily: 'Manrope',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24,), // Bolder weight for large display text
      headlineMedium: TextStyle(fontSize: 20,), // Bolder for headlines
      bodyMedium: TextStyle(fontSize: 16, ), // Medium weight for body text
      bodySmall: TextStyle(fontSize: 14, ), // Slightly bolder for small text
    ),
  );
}
