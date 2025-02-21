import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text("Sign In", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                authController.signInWithEmail(emailController.text, passwordController.text);
              },
              child: const Text("Sign In with Email"),
            ),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: authController.signInWithGoogle,
              child: const Text("Sign In with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
