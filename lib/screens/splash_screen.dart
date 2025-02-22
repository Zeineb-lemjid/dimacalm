import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_screen.dart';  // Import HomeScreen instead of HomePage
import 'login_screen.dart';
import '../controllers/auth_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController authController = Get.find<AuthController>(); // Use AuthController to check login status

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate loading time

    // Check if user is logged in using the AuthController
    if (authController.user.value != null) {
      // If logged in, navigate to HomePage
      Get.offAll(() => HomePage());
    } else {
      // If not logged in, navigate to LoginScreen
      Get.offAll(() => LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/logo.png", width: 150), // Replace with your actual logo
      ),
    );
  }
}
