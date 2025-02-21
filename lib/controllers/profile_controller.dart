import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';


class ProfileController extends GetxController {
  var userName = "".obs;
  var profileImagePath = "".obs;
  late Box userBox;

  @override
  void onInit() {
    super.onInit();
    userBox = Hive.box('userBox');
    loadProfileData();
  }

  void loadProfileData() {
    userName.value = userBox.get('name', defaultValue: "User");
    profileImagePath.value = userBox.get('profileImage', defaultValue: "");
  }

  void updateName(String name) {
    userName.value = name;
    userBox.put('name', name);
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
