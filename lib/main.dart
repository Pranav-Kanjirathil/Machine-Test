import 'package:flutter/material.dart';
import 'package:machine/views/home_view.dart';
import 'package:machine/views/login_view.dart';
import 'package:machine/views/otp_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginView(),
      // home: OtpView(),
      home: HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
