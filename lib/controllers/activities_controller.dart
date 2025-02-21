import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiesController extends GetxController {
  var selectedActivity = ''.obs; // Currently selected activity
  var activities = [
    'Exercise',
    'Meditation',
    'Reading',
    'Music',
    'Cooking',
    'Walking'
  ].obs; // List of all activities
  var filteredActivities = <String>[].obs; // List of filtered activities
  var category = ''.obs; // Selected category

  @override
  void onInit() {
    super.onInit();
    filteredActivities.value =
        List.from(activities); // Initially show all activities
  }

  // Filter activities based on the selected category
  void filterActivities(String category) {
    this.category.value = category;
    if (category == 'All') {
      filteredActivities.value = List.from(activities); // Show all activities
    } else {
      filteredActivities.value =
          activities.where((activity) => activity.contains(category)).toList();
    }
  }

  // Log the selected activity to Firestore
  void logActivity() async {
    if (selectedActivity.value.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('activities').add({
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
}
