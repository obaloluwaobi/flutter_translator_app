import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:translator_app/auth/mainpage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:translator_app/firebase_options.dart';
import 'package:translator_app/views/intro/splash.dart';
import 'package:translator_app/views/profile/about.dart';
import 'package:translator_app/views/profile/editprofile.dart';
import 'package:translator_app/views/profile/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        }),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash());
  }
}
