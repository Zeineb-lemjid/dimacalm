import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Add GetStorage
import 'dart:io';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (authController.user.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("You are not logged in", style: TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Get.to(LoginScreen()),
                  child: const Text("Go to Login"),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: profileController.pickProfileImage,
                  child: Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundImage: profileController.profileImagePath.value.isNotEmpty
                        ? FileImage(File(profileController.profileImagePath.value))
                        : (authController.user.value?.photoURL != null
                            ? NetworkImage(authController.user.value!.photoURL!)
                            : const AssetImage("assets/default_avatar.png")) as ImageProvider,
                    child: const Icon(Icons.camera_alt, size: 30, color: Colors.white70),
                  )),
                ),
                const SizedBox(height: 20),
                Obx(() => Text(
                  profileController.userName.value.isNotEmpty
                      ? profileController.userName.value
                      : (authController.user.value?.displayName ?? "User"),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )),
                const SizedBox(height: 10),
                Text(authController.user.value?.email ?? ""),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Enter your name"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    profileController.updateName(nameController.text);
                    nameController.clear();
                  },
                  child: const Text("Update Name"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authController.signOut,
                  child: const Text("Sign Out"),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('Dark Mode'),
                  trailing: Obx(() {
                    return Switch(
                      value: Get.isDarkMode,
                      onChanged: (value) {
                        GetStorage().write('isDarkMode', value);
                        Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 20),
                // Adding the additional profile fields from the 'main' branch
                Obx(
                  () => TextFormField(
                    initialValue: profileController.name.value,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => profileController.name.value = value,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    initialValue: profileController.email.value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => profileController.email.value = value,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    initialValue: profileController.preferences.value,
                    decoration: InputDecoration(
                      labelText: 'Preferences',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: (value) => profileController.preferences.value = value,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: profileController.updateProfile, // Call the update function
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Save Profile',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
