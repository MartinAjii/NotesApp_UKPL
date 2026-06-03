import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/notes_page.dart';
import 'services/auth_service.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: AuthService().getToken(),

      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const LoginPage();
        }

        final token = snapshot.data;

        if (token == null || token.isEmpty) {
          return const LoginPage();
        }

        return const NotesPage();
      },
    );
  }
}