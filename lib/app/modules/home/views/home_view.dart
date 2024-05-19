import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/api_error_widget.dart';
import '../../../components/my_widget_animator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(builder: (_) {
        return MyWidgetsAnimator(
          apiCallStatus: controller.apiCallStatus,
          loadingWidget: () => const Center(
            child: CupertinoActivityIndicator(),
          ),
          errorWidget: () => ApiErrorWidget(
            message: "Internet Error",
            retryAction: () => controller.getData(),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
          ),
          successWidget: () => SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    controller.data![0]['id'].toString(),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
