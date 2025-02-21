import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs; // Observable index for navigation

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
