// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart'; // Add GetStorage
// import 'dart:io';
// import '../controllers/auth_controller.dart';
// import '../controllers/profile_controller.dart';
// import 'login_screen.dart';

// class ProfileScreen extends StatelessWidget {
//   ProfileScreen({super.key});

//   final AuthController authController = Get.find<AuthController>();
//   final ProfileController profileController = Get.put(ProfileController());
//   final TextEditingController nameController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (authController.user.value == null) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text("You are not logged in", style: TextStyle(fontSize: 18)),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () => Get.to(LoginScreen()),
//                   child: const Text("Go to Login"),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Profile image
//                 GestureDetector(
//                   onTap: profileController.pickProfileImage,
//                   child: Obx(() => CircleAvatar(
//                     radius: 50,
//                     backgroundImage: profileController.profileImagePath.value.isNotEmpty
//                         ? FileImage(File(profileController.profileImagePath.value))
//                         : (authController.user.value?.photoURL != null
//                             ? NetworkImage(authController.user.value!.photoURL!)
//                             : const AssetImage("assets/default_avatar.png")) as ImageProvider,
//                     child: const Icon(Icons.camera_alt, size: 30, color: Colors.white70),
//                   )),
//                 ),
//                 const SizedBox(height: 20),
//                 // User name
//                 Obx(() => Text(
//                   profileController.userName.value.isNotEmpty
//                       ? profileController.userName.value
//                       : (authController.user.value?.displayName ?? "User"),
//                   style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 )),
//                 const SizedBox(height: 10),
//                 // User email
//                 Text(authController.user.value?.email ?? ""),
//                 const SizedBox(height: 20),
//                 // Name input field
//                 TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(labelText: "Enter your name"),
//                 ),
//                 const SizedBox(height: 10),
//                 // Update name button
//                 ElevatedButton(
//                   onPressed: () {
//                     profileController.updateName(nameController.text);
//                     nameController.clear();
//                   },
//                   child: const Text("Update Name"),
//                 ),
//                 const SizedBox(height: 20),
//                 // Sign-out button
//                 ElevatedButton(
//                   onPressed: authController.signOut,
//                   child: const Text("Sign Out"),
//                 ),
//                 const SizedBox(height: 20),
//                 // Dark Mode toggle
//                 ListTile(
//                   title: const Text('Dark Mode'),
//                   trailing: Obx(() {
//                     return Switch(
//                       value: Get.isDarkMode,
//                       onChanged: (value) {
//                         GetStorage().write('isDarkMode', value);
//                         Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//                       },
//                     );
//                   }),
//                 ),
//                 const SizedBox(height: 20),
//                 // Preferences input field
//                 Obx(
//                   () => TextFormField(
//                     initialValue: profileController.preferences.value,
//                     decoration: InputDecoration(
//                       labelText: 'Preferences',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                     ),
//                     onChanged: (value) => profileController.preferences.value = value,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 // Save profile button
//                 ElevatedButton(
//                   onPressed: profileController.updateProfileInFirestore,
//                   child: const Text(
//                     'Save Profile',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       }),
//     );
//   }
// }


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        // Ensure data is loaded
        if (profileController.userName.value.isEmpty &&
            profileController.email.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              GestureDetector(
                onTap: profileController.pickProfileImage,
                child: Obx(() {
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: profileController.profileImagePath.value.isNotEmpty
                        ? FileImage(File(profileController.profileImagePath.value))
                        : const AssetImage("assets/default_avatar.png") as ImageProvider,
                    child: const Icon(Icons.camera_alt, size: 30, color: Colors.white70),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Name
              Obx(() => Text(
                profileController.userName.value.isNotEmpty
                    ? profileController.userName.value
                    : "User",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 10),

              // Email
              Obx(() => Text(
                profileController.email.value.isNotEmpty
                    ? profileController.email.value
                    : "No Email",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              )),
              const SizedBox(height: 20),

              // Name Input
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Update Name Button
              ElevatedButton(
                onPressed: () {
                  profileController.updateName(nameController.text);
                  nameController.clear();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: const Text("Update Name"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
