import 'package:donations_list/donations_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'donation_create_screen.dart';
import 'firebase_options.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/home",
    routes: {
      "/home": (_) => HomeScreen(),
      "/register": (_) => RegisterScreen(),
      "/login": (_) => LoginScreen(),
      "/bem-vindo": (_) => ItemRegistrationPage(),
    },
  ));
}