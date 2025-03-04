import 'package:firebase_demo/auth/authentication_repository.dart';
import 'package:firebase_demo/user/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord(); // Fetch user data when the controller is initialized
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await AuthenticationRepository.instance.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }
}