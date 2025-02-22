import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileController extends GetxController {
//   var profileImagePath = ''.obs;
//   var userName = ''.obs;
//   var name = ''.obs;
//   var email = ''.obs;
//   var preferences = ''.obs;

//   final FirebaseAuth auth = FirebaseAuth.instance;
//   late Box userBox;

//   @override
//   void onInit() {
//     super.onInit();
//     userBox = Hive.box('userBox');
//     loadProfileData();
//     fetchUserProfile(); // Fetch profile from Firestore
//   }

//   // Load profile data from Hive (local storage)
//   void loadProfileData() {
//     userName.value = userBox.get('name', defaultValue: "User");
//     profileImagePath.value = userBox.get('profileImage', defaultValue: "");
//   }

//   // Fetch user profile from Firestore
//   void fetchUserProfile() async {
//     try {
//       User? user = auth.currentUser;
//       if (user != null) {
//         DocumentSnapshot doc = await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//         if (doc.exists) {
//           name.value = doc['name'] ?? ''; // Handle null safety
//           email.value = doc['email'] ?? ''; // Handle null safety
//           preferences.value = doc['preferences'] ?? ''; // Handle null safety
//         }
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to fetch profile: $e');
//     }
//   }

//   // Update the user's name in Hive and Firestore
//   void updateName(String newName) {
//     userName.value = newName;
//     userBox.put('name', newName); // Save locally in Hive
//     updateProfileInFirestore(); // Update in Firestore
//   }

//   // Pick a profile image and update locally and remotely
//   void pickProfileImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       profileImagePath.value = pickedFile.path;
//       userBox.put('profileImage', pickedFile.path); // Save locally in Hive
//       updateProfileInFirestore(); // Update in Firestore
//     }
//   }

//   // Update user profile in Firestore
//   void updateProfileInFirestore() async {
//     try {
//       User? user = auth.currentUser;
//       if (user != null) {
//         await FirebaseFirestore.instance.collection('users').doc(user.uid).set(
//           {
//             'name': userName.value,
//             'email': email.value,
//             'preferences': preferences.value,
//           },
//           SetOptions(merge: true), // Merge with existing data
//         );
//         Get.snackbar('Success', 'Profile updated successfully!');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to update profile: $e');
//     }
//   }

//   // Update profile method
//   void updateProfile() {
//     // Additional logic for updating profile if needed.
//   }
// }



class ProfileController extends GetxController {
  var profileImagePath = ''.obs;
  var userName = ''.obs;
  var email = ''.obs;

  late Box userBox;

  @override
  void onInit() {
    super.onInit();
    userBox = Hive.box('userBox');
    loadProfileData();
  }

  void loadProfileData() {
    userName.value = userBox.get('name', defaultValue: "User");
    email.value = userBox.get('email', defaultValue: "No Email");
    profileImagePath.value = userBox.get('profileImage', defaultValue: "");
  }

  void updateName(String newName) {
    if (newName.isNotEmpty) {
      userName.value = newName;
      userBox.put('name', newName);
    }
  }

  void pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImagePath.value = pickedFile.path;
      userBox.put('profileImage', pickedFile.path);
    }
  }
}
