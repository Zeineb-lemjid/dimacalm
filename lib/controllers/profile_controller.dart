import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  // Observable variables for profile data
  var name = ''.obs;
  var email = ''.obs;
  var preferences = ''.obs;

  // Firebase Auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile(); // Fetch user profile when the controller is initialized
  }

  // Fetch user profile from Firestore
  void fetchUserProfile() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          // Update observed variables with data from Firestore
          name.value = doc['name'] ?? ''; // Handle null safety
          email.value = doc['email'] ?? ''; // Handle null safety
          preferences.value = doc['preferences'] ?? ''; // Handle null safety
        }
      }
    } catch (e) {
      // Handle errors (e.g., network issues, Firestore errors)
      Get.snackbar('Error', 'Failed to fetch profile: $e');
    }
  }

  // Update user profile in Firestore
  void updateProfile() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
          {
            'name': name.value,
            'email': email.value,
            'preferences': preferences.value,
          },
          SetOptions(merge: true), // Merge with existing data
        );
        Get.snackbar('Success', 'Profile updated successfully!');
      }
    } catch (e) {
      // Handle errors (e.g., network issues, Firestore errors)
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}
