import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivitiesController extends GetxController {
  var selectedActivity = ''.obs; // Currently selected activity
  var activities = [
    {'name': 'Exercise', 'category': 'Physical'},
    {'name': 'Meditation', 'category': 'Mental'},
    {'name': 'Reading', 'category': 'Intellectual'},
    {'name': 'Music', 'category': 'Relaxation'},
    {'name': 'Cooking', 'category': 'Creative'},
    {'name': 'Walking', 'category': 'Physical'},
  ].obs; // List of activities with categories

  var filteredActivities = <Map<String, String>>[].obs; // Filtered activities list
  var category = 'All'.obs; // Default category

  @override
  void onInit() {
    super.onInit();
    filterActivities('All'); // Show all activities initially
    fetchLoggedActivities(); // Fetch logged activities from Firestore
  }

  // Filter activities based on category
  void filterActivities(String selectedCategory) {
    category.value = selectedCategory;
    if (selectedCategory == 'All') {
      filteredActivities.assignAll(activities);
    } else {
      filteredActivities.assignAll(
          activities.where((activity) => activity['category'] == selectedCategory));
    }
  }

  // Log the selected activity to Firestore
  void logActivity() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'User not logged in');
      return;
    }

    if (selectedActivity.value.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('activities').add({
          'userId': user.uid, // Store user ID
          'activity': selectedActivity.value,
          'category': category.value,
          'timestamp': Timestamp.now(),
        });
        Get.snackbar('Success', 'Activity logged successfully!');
      } catch (e) {
        Get.snackbar('Error', 'Failed to log activity: $e');
      }
    } else {
      Get.snackbar('Error', 'Please select an activity');
    }
  }

  // Fetch logged activities from Firestore
  void fetchLoggedActivities() {
    FirebaseFirestore.instance
        .collection('activities')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      activities.clear(); // Clear the current list of activities
      for (var doc in snapshot.docs) {
        activities.add({
          'name': doc['activity'], // Activity name
          'category': doc['category'], // Category
          'timestamp': doc['timestamp'], // Timestamp
        });
      }
    });
  }
}
