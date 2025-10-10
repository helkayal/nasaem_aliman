import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtils {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }

  static bool isPhone(BuildContext context) {
    return !isTablet(context);
  }

  /// Responsive width that scales better on tablets
  static double responsiveWidth(double width) {
    if (1.sw >= 600) {
      // On tablets, limit the scaling factor
      return width * min(1.2, 1.sw / 360);
    }
    return width.w;
  }

  /// Responsive height that scales better on tablets
  static double responsiveHeight(double height) {
    if (1.sw >= 600) {
      // On tablets, limit the scaling factor
      return height * min(1.3, 1.sh / 690);
    }
    return height.h;
  }

  /// Responsive font size
  static double responsiveFontSize(double fontSize) {
    if (1.sw >= 600) {
      // On tablets, scale font size more conservatively
      return fontSize * min(1.1, 1.sw / 360);
    }
    return fontSize.sp;
  }

  /// Responsive padding that works well on both phones and tablets
  static EdgeInsets responsivePadding({
    double horizontal = 16,
    double vertical = 16,
  }) {
    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(horizontal),
      vertical: responsiveHeight(vertical),
    );
  }

  /// Get responsive margin
  static EdgeInsets responsiveMargin({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(horizontal),
      vertical: responsiveHeight(vertical),
    );
  }

  // 🔹 TABLET-AWARE ENHANCED METHODS (Approach 3)

  /// Tablet-aware responsive width with custom multiplier
  static double tabletAwareWidth(
    BuildContext context,
    double width, {
    double tabletMultiplier = 1.5,
  }) {
    final baseWidth = isTablet(context) ? width * tabletMultiplier : width;
    return responsiveWidth(baseWidth);
  }

  /// Tablet-aware responsive height with custom multiplier
  static double tabletAwareHeight(
    BuildContext context,
    double height, {
    double tabletMultiplier = 1.5,
  }) {
    final baseHeight = isTablet(context) ? height * tabletMultiplier : height;
    return responsiveHeight(baseHeight);
  }

  /// Tablet-aware responsive font size with custom multiplier
  static double tabletAwareFontSize(
    BuildContext context,
    double fontSize, {
    double tabletMultiplier = 2,
  }) {
    final baseFontSize = isTablet(context)
        ? fontSize * tabletMultiplier
        : fontSize;
    return responsiveFontSize(baseFontSize);
  }

  /// Tablet-aware responsive padding
  static EdgeInsets tabletAwarePadding(
    BuildContext context, {
    double horizontal = 16,
    double vertical = 16,
    double tabletMultiplier = 1.8,
  }) {
    return EdgeInsets.symmetric(
      horizontal: tabletAwareWidth(
        context,
        horizontal,
        tabletMultiplier: tabletMultiplier,
      ),
      vertical: tabletAwareHeight(
        context,
        vertical,
        tabletMultiplier: tabletMultiplier,
      ),
    );
  }

  /// Tablet-aware responsive margin
  static EdgeInsets tabletAwareMargin(
    BuildContext context, {
    double horizontal = 0,
    double vertical = 0,
    double tabletMultiplier = 1.8,
  }) {
    return EdgeInsets.symmetric(
      horizontal: tabletAwareWidth(
        context,
        horizontal,
        tabletMultiplier: tabletMultiplier,
      ),
      vertical: tabletAwareHeight(
        context,
        vertical,
        tabletMultiplier: tabletMultiplier,
      ),
    );
  }

  /// Tablet-aware icon size
  static double tabletAwareIconSize(
    BuildContext context,
    double iconSize, {
    double tabletMultiplier = 1.6,
  }) {
    final baseIconSize = isTablet(context)
        ? iconSize * tabletMultiplier
        : iconSize;
    return responsiveWidth(baseIconSize);
  }
}
