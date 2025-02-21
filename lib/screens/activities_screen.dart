import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/activities_controller.dart';

class ActivitiesScreen extends StatelessWidget {
  ActivitiesScreen({Key? key}) : super(key: key);

  final ActivitiesController controller = Get.put(ActivitiesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Activity'),
        centerTitle: true,
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
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  hint: const Text('Select category'),
                  value: controller.category.value.isNotEmpty
                      ? controller.category.value
                      : null,
                  isExpanded: true,
                  items: const ['All', 'Physical', 'Mental', 'Leisure']
                      .map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.category.value = value;
                      controller.filterActivities(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // List of filtered activities
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredActivities.length,
                  itemBuilder: (context, index) {
                    final activity = controller.filteredActivities[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ListTile(
                        title: Text(activity),
                        trailing: IconButton(
                          icon: const Icon(Icons.add),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: Colors.blue,
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
