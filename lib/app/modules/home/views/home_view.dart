import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/components/custom_app_bar.dart';

import '../../../../utils/constants.dart';
import '../../../components/api_error_widget.dart';
import '../../../components/custom_image_view.dart';
import '../../../components/my_widget_animator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: const CustomAppBar(
        title: "TRACTIAN",
        hasDrawer: false,
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
          successWidget: () => ListView.builder(
            itemCount: controller.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final companyId = controller.data![index]['id'];
                  Get.toNamed('/assets', arguments: {'companyId': companyId});
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: theme.primaryColor,
                  ),
                  margin: EdgeInsets.only(
                    top: 40.0.h,
                    left: 22.0.w,
                    right: 22.0.w,
                  ),
                  padding: EdgeInsets.only(
                    left: 32.0.w,
                    top: 32.0.h,
                    bottom: 32.0.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        svgPath: Constants.box,
                        width: 24.w,
                      ),
                      16.horizontalSpace,
                      Text(
                        controller.data![index]['name'].toString(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontSize: 18.sp,
                          height: 1.28.h,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
