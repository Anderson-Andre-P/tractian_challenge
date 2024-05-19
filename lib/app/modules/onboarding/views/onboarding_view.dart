import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../../../data/local/my_shared_preferences.dart';
import '../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = MySharedPref.getThemeIsLight();
    final theme = context.theme;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: isLightTheme
                  ? theme.scaffoldBackgroundColor
                  : theme.scaffoldBackgroundColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                95.verticalSpace,
                CircleAvatar(
                  radius: 33.r,
                  backgroundColor: theme.primaryColorDark,
                  child: Image.asset(
                    Constants.logo,
                    width: 40.33.w,
                    height: 33.40.h,
                  ),
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
                30.verticalSpace,
                Text(
                  'Get a awesome experience',
                  style: theme.textTheme.displayLarge,
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
                24.verticalSpace,
                Text(
                  'The best app for your necessities',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ).animate().fade().slideY(
                      duration: 300.ms,
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
                40.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 70.w),
                  child: CustomButton(
                    text: 'Enter in the App',
                    onPressed: () => Get.offNamed(Routes.BASE),
                    fontSize: 16.sp,
                    verticalPadding: 16.h,
                    hasShadow: false,
                  ).animate().fade().slideY(
                        duration: 300.ms,
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
