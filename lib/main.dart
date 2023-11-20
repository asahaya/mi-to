import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '03_start_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mi-to',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashColor: Colors.black,
        primaryColor: Colors.amber,
        fontFamily: 'BIZUDGothic',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: UserInformation(),
      home: const StartScreen(),
    );
  }
}
