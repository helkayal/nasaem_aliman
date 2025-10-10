import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUtils {
  /// Responsive width for mobile phones
  static double responsiveWidth(double width) {
    return width.w;
  }

  /// Responsive height for mobile phones
  static double responsiveHeight(double height) {
    return height.h;
  }

  /// Responsive font size for mobile phones
  static double responsiveFontSize(double fontSize) {
    return fontSize.sp;
  }

  /// Responsive padding for mobile phones
  static EdgeInsets responsivePadding({
    double horizontal = 16,
    double vertical = 16,
  }) {
    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(horizontal),
      vertical: responsiveHeight(vertical),
    );
  }

  /// Responsive margin for mobile phones
  static EdgeInsets responsiveMargin({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(horizontal),
      vertical: responsiveHeight(vertical),
    );
  }
}
