import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs; // Rx variable for reactive state

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
