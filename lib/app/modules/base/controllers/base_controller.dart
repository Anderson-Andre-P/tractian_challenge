import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';

class BaseController extends GetxController {
  // current screen index
  int currentIndex = 0;

  final HomeController homeController = Get.put(HomeController());

  /// change the selected screen index
  void changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    if (currentIndex == 0) {
      homeController.getData();
    }
    update();
  }
}
