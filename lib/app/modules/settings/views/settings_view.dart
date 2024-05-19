import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/translations/localization_service.dart';
import '../../../../config/translations/strings_enum.dart';
import '../../../components/custom_app_bar.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_list.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final theme = context.theme;
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.serverError.tr,
        hasDrawer: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsList(
                titleOfList: Strings.serverError.tr,
                items: [
                  SettingsItem(
                    icon: Icons.translate_outlined,
                    phrase: Strings.serverError.tr,
                    arrowIcon: Icons.arrow_forward_outlined,
                    onPressed: () {
                      LocalizationService.updateLanguage(
                        LocalizationService.getCurrentLocal().languageCode ==
                                'en'
                            ? 'pt'
                            : 'en',
                      );
                    },
                  ),
                  SettingsItem(
                    icon: Icons.swap_horiz_outlined,
                    phrase: Strings.serverError.tr,
                    arrowIcon: Icons.arrow_forward,
                    isToggle: true,
                    onToggle: (value) {
                      controller.changeTheme(value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
