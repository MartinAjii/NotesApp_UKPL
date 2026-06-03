import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'notes_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState()
      => _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final usernameController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final authService =
      AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: Padding(
        padding:
        const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
              usernameController,
              decoration:
              const InputDecoration(
                labelText:
                "Username",
              ),
            ),

            TextField(
              controller:
              passwordController,
              obscureText: true,
              decoration:
              const InputDecoration(
                labelText:
                "Password",
              ),
            ),

            const SizedBox(
                height: 20),

            ElevatedButton(
              onPressed: () async {

              try {

                print("Tombol login ditekan");

                bool success =
                    await authService.login(
                  usernameController.text,
                  passwordController.text,
                );

                print("Login result: $success");

                if (success) {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotesPage(),
                    ),
                  );
                }

              } catch (e) {

                print("ERROR LOGIN:");
                print(e);
              }
            },
              child:
              const Text("Login"),
            ),

            TextButton(
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_)
                    => const RegisterPage(),
                  ),
                );
              },
              child:
              const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}