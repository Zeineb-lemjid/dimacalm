import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = Rx<User?>(null);
  late Box userBox;

  @override
  void onInit() {
    super.onInit();
    userBox = Hive.box('userBox');
    user.value = auth.currentUser;
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      user.value = userCredential.user;

      // Save user data in Hive
      userBox.put('name', user.value?.displayName ?? "User");
      userBox.put('email', user.value?.email ?? "");
      userBox.put('profileImage', user.value?.photoURL ?? "");
    } catch (e) {
      Get.snackbar("Error", "Google Sign-In Failed");
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user.value = userCredential.user;

      userBox.put('name', user.value?.email ?? "User");
    } catch (e) {
      Get.snackbar("Error", "Login Failed");
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    user.value = null;

    userBox.delete('name');
    userBox.delete('email');
    userBox.delete('profileImage');
    Get.offAllNamed('/login');
  }
}
