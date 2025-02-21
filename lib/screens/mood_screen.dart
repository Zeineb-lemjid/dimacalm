import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mood_controller.dart';

class MoodScreen extends StatelessWidget {
  MoodScreen({super.key});

  final MoodController moodController = Get.put(MoodController());

  final List<Map<String, dynamic>> moods = [
    {"name": "Happy", "icon": Icons.sentiment_very_satisfied, "color": Colors.yellow},
    {"name": "Sad", "icon": Icons.sentiment_dissatisfied, "color": Colors.blue},
    {"name": "Anxious", "icon": Icons.sentiment_neutral, "color": Colors.orange},
    {"name": "Calm", "icon": Icons.self_improvement, "color": Colors.green},
    {"name": "Stressed", "icon": Icons.sentiment_very_dissatisfied, "color": Colors.red},
  ];

  void confirmDelete(int index) {
    Get.defaultDialog(
      title: "Delete Mood",
      middleText: "Are you sure you want to remove this entry?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        moodController.deleteMood(index);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mood Tracker")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("How are you feeling today?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: moods.map((mood) {
                return ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mood["color"],
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => moodController.setMood(mood["name"]),
                  icon: Icon(mood["icon"]),
                  label: Text(mood["name"]),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Obx(() => moodController.selectedMood.value.isNotEmpty
                ? Text("You selected: ${moodController.selectedMood.value}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                : const Text("No mood selected", style: TextStyle(fontSize: 16))),
            const Divider(height: 30),
            const Text("Mood History:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: Obx(() => moodController.moodHistory.isNotEmpty
                  ? ListView.builder(
                      itemCount: moodController.moodHistory.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          child: ListTile(
                            leading: const Icon(Icons.history, color: Colors.blue),
                            title: Text(moodController.moodHistory[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => confirmDelete(index),
                            ),
                          ),
                        );
                      },
                    )
                  : const Text("No moods logged yet.", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic))),
            ),
          ],
        ),
      ),
    );
  }
}
