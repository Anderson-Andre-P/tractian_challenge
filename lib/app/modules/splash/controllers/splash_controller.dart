import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 10));
    Get.offNamed(Routes.ONBOARDING);
    super.onInit();
  }
}
