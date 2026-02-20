import 'package:flutter/material.dart';
import 'package:machine/view_models/user_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:machine/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
      ),
    );
  }
}
