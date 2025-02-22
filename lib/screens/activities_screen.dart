// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../controllers/activities_controller.dart';

// class ActivitiesScreen extends StatelessWidget {
//   ActivitiesScreen({super.key});

//   final ActivitiesController controller = Get.put(ActivitiesController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Log Activity'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Dropdown for category selection
//             Obx(
//               () => Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: DropdownButton<String>(
//                   hint: const Text('Select category'),
//                   value: controller.category.value.isNotEmpty
//                       ? controller.category.value
//                       : null,
//                   isExpanded: true,
//                   items: const [
//                     'All',
//                     'Physical',
//                     'Mental',
//                     'Intellectual',
//                     'Relaxation',
//                     'Creative'
//                   ].map((String category) {
//                     return DropdownMenuItem<String>(
//                       value: category,
//                       child: Text(category),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     if (value != null) {
//                       controller.filterActivities(value);
//                     }
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Selected activity display
//             Obx(() => controller.selectedActivity.value.isNotEmpty
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Selected: ${controller.selectedActivity.value}',
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   )
//                 : const SizedBox()),

//             // List of filtered activities
//             Expanded(
//               child: Obx(
//                 () => ListView.builder(
//                   itemCount: controller.filteredActivities.length,
//                   itemBuilder: (context, index) {
//                     final activity = controller.filteredActivities[index]['name']!;
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: ListTile(
//                         title: Text(activity),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.add),
//                           onPressed: () {
//                             controller.selectedActivity.value = activity;
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // List of all activities
//             Expanded(
//               child: Obx(
//                 () => ListView.builder(
//                   itemCount: controller.activities.length,
//                   itemBuilder: (context, index) {
//                     final activity = controller.activities[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 4.0),
//                       child: ListTile(
//                         title: Text(activity['name']),
//                         subtitle: Text('Category: ${activity['category']}'),
//                         trailing: Text(activity['timestamp'].toDate().toString()), // Format the timestamp as needed
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Log Activity Button
//             ElevatedButton(
//               onPressed: controller.logActivity,
//               style: ElevatedButton.styleFrom(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: const Text(
//                 'Log Activity',
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ActivitiesController extends GetxController {
//   var category = ''.obs;
//   var selectedActivity = ''.obs;
//   var filteredActivities = <Map<String, String>>[].obs;
//   var activities = <Map<String, dynamic>>[].obs;

//   void filterActivities(String selectedCategory) {
//     // Implement your filtering logic here
//   }

//   void logActivity() async {
//     if (selectedActivity.value.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance.collection('activities').add({
//           'activity': selectedActivity.value,
//           'category': category.value,
//           'timestamp': Timestamp.now(),
//         });
//         Get.snackbar('Success', 'Activity logged successfully!');
//       } catch (e) {
//         Get.snackbar('Error', 'Failed to log activity: $e');
//       }
//     } else {
//       Get.snackbar('Error', 'Please select an activity');
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/activities_controller.dart';  // import the controller

class ActivitiesScreen extends StatelessWidget {
  ActivitiesScreen({super.key});

  final ActivitiesController controller = Get.put(ActivitiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Log'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,  // Blue color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for category selection
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Select Category'),
                  value: controller.category.value.isNotEmpty
                      ? controller.category.value
                      : null,
                  isExpanded: true,
                  items: const [
                    'All',
                    'Physical',
                    'Mental',
                    'Intellectual',
                    'Relaxation',
                    'Creative'
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.filterActivities(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Selected activity display
            Obx(() => controller.selectedActivity.value.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Selected: ${controller.selectedActivity.value}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  )
                : const SizedBox()),

            const SizedBox(height: 20),

            // List of filtered activities
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredActivities.length,
                  itemBuilder: (context, index) {
                    final activity = controller.filteredActivities[index]['name']!;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          activity,
                          style: const TextStyle(fontSize: 18),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.add, color: Colors.blueAccent),
                          onPressed: () {
                            controller.selectedActivity.value = activity;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Log Activity Button
            ElevatedButton(
              onPressed: controller.logActivity,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: Colors.blueAccent,  // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'Log Activity',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

