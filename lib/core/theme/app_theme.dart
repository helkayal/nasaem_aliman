import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';

import 'app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightGrey,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      centerTitle: true,
      elevation: 6,
      shadowColor: AppColors.darkBlue.withValues(alpha: 0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      titleTextStyle: TextStyle(
        color: AppColors.lightGrey,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: const IconThemeData(color: AppColors.white, size: 30),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 20.sp,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 20.sp,
        color: AppColors.darkBlue,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.darkBlue,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 28.sp,
        color: AppColors.darkBlue,
        fontFamily: AppConstants.quranFontFamily,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.darkBlue,
      onPrimary: AppColors.lightBlue,
      secondary: AppColors.lightGrey,
      onSecondary: AppColors.blue,
      error: AppColors.pink,
      onError: AppColors.pink,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      showUnselectedLabels: false,
      elevation: 8,
      unselectedItemColor: AppColors.lightBlue,
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightBlue,
        size: 30.r,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightGrey,
      selectedIconTheme: IconThemeData(color: AppColors.lightGrey, size: 30.r),
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(fontSize: 20.sp),
      labelPadding: const EdgeInsets.symmetric(vertical: 8),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBlue,
      thickness: 1.5,
      indent: 20.w,
      endIndent: 20.w,
    ),
  );
}

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBlue,
      centerTitle: true,
      elevation: 6,
      shadowColor: AppColors.blue.withValues(alpha: 0.3),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      titleTextStyle: TextStyle(
        color: AppColors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: const IconThemeData(color: AppColors.white, size: 30),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: 20.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: 24.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: 20.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: 24.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: 28.sp,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.darkBlue,
      onPrimary: AppColors.lightBlue,
      secondary: AppColors.lightGrey,
      onSecondary: AppColors.blue,
      error: AppColors.pink,
      onError: AppColors.pink,
      surface: AppColors.black,
      onSurface: AppColors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      showUnselectedLabels: false,
      elevation: 8,
      unselectedItemColor: AppColors.lightGrey,
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: 30.r,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightBlue,
      selectedIconTheme: IconThemeData(color: AppColors.lightBlue, size: 30.r),
      selectedLabelStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(fontSize: 20.sp),
      labelPadding: const EdgeInsets.symmetric(vertical: 8),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.lightBlue,
      thickness: 1.5,
      indent: 20.w,
      endIndent: 20.w,
    ),
  );
}
