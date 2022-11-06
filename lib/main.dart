import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoflutter/pages/splash.dart';
import 'pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          backgroundColor: Colors.blue,
          splash: Center(
            child: Container(
              child: const Text("Got stuff to do?",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            ),
          ),
          duration: 2000,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: AnimatedSplashScreen(
              backgroundColor: Colors.lightBlueAccent,
              splash: Center(
                child: Container(
                  child: const Text("Get it Done.",
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ),
              ),
              duration: 2000,
              splashTransition: SplashTransition.fadeTransition,
              nextScreen: const HomePage())),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
