import 'package:flutter/material.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';
import 'package:nasaem_aliman/core/utils/responsive_utils.dart';

import 'app_colors.dart';

ThemeData lightTheme(BuildContext context) {
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
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 18),
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 22),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 26),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 22),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 16),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        color: AppColors.darkBlue,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        color: AppColors.darkBlue,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 28),
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
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightGrey,
      selectedIconTheme: IconThemeData(
        color: AppColors.lightGrey,
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
      selectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
      ),
      labelPadding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.tabletAwareHeight(context, 8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.darkBlue,
      thickness: 1.5,
      indent: ResponsiveUtils.tabletAwareWidth(context, 20),
      endIndent: ResponsiveUtils.tabletAwareWidth(context, 20),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
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
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 18),
        fontWeight: FontWeight.bold,
        fontFamily: AppConstants.textFontFamily,
      ),
      iconTheme: IconThemeData(
        color: AppColors.white,
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 22),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      headlineLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 26),
        fontWeight: FontWeight.bold,
        color: AppColors.darkGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displaySmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      displayLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 26),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodySmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 16),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      bodyLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      titleSmall: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleMedium: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        color: AppColors.lightGrey,
        fontFamily: AppConstants.quranFontFamily,
      ),
      titleLarge: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 28),
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
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightGrey,
        fontFamily: AppConstants.textFontFamily,
      ),
      selectedItemColor: AppColors.lightBlue,
      selectedIconTheme: IconThemeData(
        color: AppColors.lightBlue,
        size: ResponsiveUtils.tabletAwareIconSize(context, 30),
      ),
      selectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 14),
        fontWeight: FontWeight.bold,
        color: AppColors.lightBlue,
        fontFamily: AppConstants.textFontFamily,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: AppColors.lightGrey,
      labelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 24),
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelColor: AppColors.lightBlue,
      unselectedLabelStyle: TextStyle(
        fontSize: ResponsiveUtils.tabletAwareFontSize(context, 20),
      ),
      labelPadding: EdgeInsets.symmetric(
        vertical: ResponsiveUtils.tabletAwareHeight(context, 8),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.lightBlue,
      thickness: 1.5,
      indent: ResponsiveUtils.tabletAwareWidth(context, 20),
      endIndent: ResponsiveUtils.tabletAwareWidth(context, 20),
    ),
  );
}
