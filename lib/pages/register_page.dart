import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState()
      => _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

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
        title: const Text("Register"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {

                bool success =
                await authService.register(
                  usernameController.text,
                  passwordController.text,
                );

                if(success){

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Register berhasil",
                      ),
                    ),
                  );

                  Navigator.pop(context);

                }else{

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Register gagal",
                      ),
                    ),
                  );
                }
              },
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}