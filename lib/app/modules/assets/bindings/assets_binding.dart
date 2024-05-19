import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    final arguments = Get.arguments as Map<String, dynamic>;
    final companyId = arguments['companyId'] as String;

    Get.lazyPut<AssetsController>(
      () => AssetsController(companyId),
    );
  }
}
