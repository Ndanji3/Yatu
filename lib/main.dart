import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yatu/global/global.dart';
import 'package:yatu/splashScreen/my_splash_screen.dart';
import 'dart:developer' as devtools show log;



Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyCtuZbFzl1L2joJXAui0Gwzq44VyOfwf0E",     // take these values from your index.html.
      appId: "1:796578778076:android:6bd8fbb9757e3bc4e79d19",        //code which you pasted from firebase.
      messagingSenderId: "796578778076",
      projectId: "yatu-461ad",
    ),
  );

  runApp(const MyApp());

}

extension Log on Object {
  void log() => devtools.log(toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Pastures',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      home: MySplashScreen(),
    );
  }
}


