import 'package:get/get.dart';
import 'package:hive/hive.dart';

class MoodController extends GetxController {
  var selectedMood = "".obs;
  var moodHistory = <String>[].obs;
  late Box<String> moodBox;

  @override
  void onInit() {
    super.onInit();
    moodBox = Hive.box<String>('moodBox');
    loadMoodHistory();
  }

  void setMood(String mood) {
    String timestamp = DateTime.now().toString().substring(0, 16); // Format: YYYY-MM-DD HH:mm
    String moodEntry = "$timestamp - $mood";

    selectedMood.value = mood;
    moodHistory.add(moodEntry);
    moodBox.add(moodEntry); // Save full entry with timestamp
  }

  void deleteMood(int index) {
    moodBox.deleteAt(index); // Remove from Hive storage
    moodHistory.removeAt(index); // Update UI
  }

  void loadMoodHistory() {
    moodHistory.addAll(moodBox.values);
  }
}
