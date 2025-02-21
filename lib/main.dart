import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';  
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  await Hive.initFlutter();
  await Hive.openBox<String>('moodBox'); // Open Hive box for storing mood history
  await Hive.openBox('userBox'); // Box for storing user profile data
  await GetStorage.init();  // Initialize GetStorage

  runApp(const MentalHealthApp());
}

class MentalHealthApp extends StatelessWidget {
  const MentalHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load saved theme preference
    bool isDarkMode = GetStorage().read('isDarkMode') ?? false;
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Toggle based on saved preference
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      home: const SplashScreen(), // Start with Splash Screen
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    );
  }
}
