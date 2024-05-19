import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/local/my_shared_preferences.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'my_styles.dart';

class MyTheme {
  static ThemeData getThemeData({required bool isLight}) {
    return ThemeData(
      primaryColor: isLight
          ? LightThemeColors.primaryColor
          : DarkThemeColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: isLight
            ? LightThemeColors.accentColor
            : DarkThemeColors.accentColor,
        backgroundColor: isLight
            ? LightThemeColors.backgroundColor
            : DarkThemeColors.backgroundColor,
        brightness: isLight ? Brightness.light : Brightness.dark,
      ).copyWith(
        secondary: isLight
            ? LightThemeColors.accentColor
            : DarkThemeColors.accentColor,
      ),
      brightness: isLight ? Brightness.light : Brightness.dark,
      cardColor:
          isLight ? LightThemeColors.cardColor : DarkThemeColors.cardColor,
      hintColor: isLight
          ? LightThemeColors.hintTextColor
          : DarkThemeColors.hintTextColor,
      dividerColor: isLight
          ? LightThemeColors.dividerColor
          : DarkThemeColors.dividerColor,
      scaffoldBackgroundColor: isLight
          ? LightThemeColors.scaffoldBackgroundColor
          : DarkThemeColors.scaffoldBackgroundColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: isLight
            ? LightThemeColors.primaryColor
            : DarkThemeColors.primaryColor,
      ),
      appBarTheme: MyStyles.getAppBarTheme(isLightTheme: isLight),
      elevatedButtonTheme:
          MyStyles.getElevatedButtonTheme(isLightTheme: isLight),
      textTheme: MyStyles.getTextTheme(isLightTheme: isLight),
      chipTheme: MyStyles.getChipTheme(isLightTheme: isLight),
      iconTheme: MyStyles.getIconTheme(isLightTheme: isLight),
      listTileTheme: MyStyles.getListTileThemeData(isLightTheme: isLight),
      extensions: [
        MyStyles.getHeaderContainerTheme(isLightTheme: isLight),
        MyStyles.getEmployeeListItemTheme(isLightTheme: isLight),
      ],
    );
  }

  static void changeTheme() {
    bool isLightTheme = MySharedPref.getThemeIsLight();
    print("Current theme before change: $isLightTheme");
    MySharedPref.setThemeIsLight(!isLightTheme);
    Get.changeThemeMode(!isLightTheme ? ThemeMode.light : ThemeMode.dark);
    print("Theme changed to: ${!isLightTheme ? 'light' : 'dark'}");
  }

  bool get getThemeIsLight => MySharedPref.getThemeIsLight();
}
