import 'package:get/get.dart';

import '../../../../config/theme/my_theme.dart';
import '../../../data/local/my_shared_preferences.dart';

class SettingsController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();

  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }
}
