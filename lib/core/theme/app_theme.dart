import 'package:flutter/material.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';
import 'package:nasaem_aliman/core/utils/responsive_utils.dart';

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
        fontSize: ResponsiveUtils.responsiveFontSize(18),
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(22),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(26),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(22),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(14),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(18),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(22),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
        color: AppColors.black,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        color: AppColors.black,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(28),
        color: AppColors.black,
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
      tertiary: AppColors.gold,
      onTertiary: AppColors.teal,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      showUnselectedLabels: false,
      elevation: 8,
      unselectedItemColor: AppColors.lightBlue,
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightBlue,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightGrey,
      selectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
      selectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
      ),
      labelPadding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.responsiveHeight(8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBlue,
      thickness: 1.5,
      indent: ResponsiveUtils.responsiveWidth(20),
      endIndent: ResponsiveUtils.responsiveWidth(20),
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
        fontSize: ResponsiveUtils.responsiveFontSize(18),
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(22),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(26),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(26),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(16),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(28),
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
      tertiary: AppColors.gold,
      onTertiary: AppColors.teal,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBlue,
      showUnselectedLabels: false,
      elevation: 8,
      unselectedItemColor: AppColors.lightGrey,
      unselectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightBlue,
      selectedIconTheme: IconThemeData(
        color: AppColors.lightBlue,
        size: ResponsiveUtils.responsiveWidth(30),
      ),
      selectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(24),
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.responsiveFontSize(20),
      ),
      labelPadding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.responsiveHeight(8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.lightBlue,
      thickness: 1.5,
      indent: ResponsiveUtils.responsiveWidth(20),
      endIndent: ResponsiveUtils.responsiveWidth(20),
    ),
  );
}
