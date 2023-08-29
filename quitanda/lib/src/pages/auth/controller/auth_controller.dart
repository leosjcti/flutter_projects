import 'package:get/get.dart';
import 'package:quitanda/src/models/user_model.dart';
import 'package:quitanda/src/pages/auth/repository/auth_repository.dart';
import 'package:quitanda/src/pages/auth/result/auth_result.dart';
import 'package:quitanda/src/pages/pages_routes/app_pages.dart';
import 'package:quitanda/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilServices = UtilServices();
  UserModel user = UserModel();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;
        Get.offNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }
}
