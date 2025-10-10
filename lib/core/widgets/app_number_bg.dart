import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../utils/responsive_utils.dart';

class AppNumberBg extends StatelessWidget {
  const AppNumberBg({
    super.key,
    required this.fontScale,
    required this.isDark,
    required this.rowNumber,
  });

  final String fontScale;
  final bool isDark;
  final String rowNumber;

  @override
  Widget build(BuildContext context) {
    // Get responsive size based on font scale
    final containerSize = fontScale == "large"
        ? 50.w
        : fontScale == "medium"
        ? 40.w
        : fontScale == "small"
        ? 30.w
        : 25.w;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Container(
        width: containerSize,
        height: containerSize,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark ? AppAssets.numberBgDark : AppAssets.numberBg,
            ),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            rowNumber,
            textAlign: TextAlign.center,
            style:
                (fontScale == "large"
                        ? Theme.of(context).textTheme.bodyLarge
                        : fontScale == "medium"
                        ? Theme.of(context).textTheme.bodyMedium
                        : fontScale == "small"
                        ? Theme.of(context).textTheme.bodySmall
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: ResponsiveUtils.responsiveFontSize(
                              AppConstants.xsmallFontSize,
                            ),
                          ))
                    ?.copyWith(
                      height:
                          1.0, // Ensures tight line height for better centering
                      fontWeight:
                          FontWeight.w600, // Better visibility on background
                    ),
          ),
        ),
      ),
    );
  }
}
