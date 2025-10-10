import 'package:flutter/material.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';

import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/app_number_bg.dart';

class ListRow extends StatelessWidget {
  final String text;
  final String rowNumber;
  final String rowTrailer;
  final bool withTrailer;
  final bool withLeading;
  final String fontScale;

  const ListRow({
    super.key,
    required this.text,
    required this.rowNumber,
    required this.rowTrailer,
    this.withTrailer = true,
    this.withLeading = true,
    this.fontScale = "large",
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        withTrailer
            ? Expanded(
                child: Text(
                  rowTrailer,
                  style: fontScale == "large"
                      ? Theme.of(context).textTheme.bodyLarge
                      : fontScale == "medium"
                      ? Theme.of(context).textTheme.bodyMedium
                      : Theme.of(context).textTheme.bodySmall,
                ),
              )
            : SizedBox.shrink(),
        Text(
          text,
          style: fontScale == "large"
              ? Theme.of(context).textTheme.bodyLarge
              : fontScale == "medium"
              ? Theme.of(context).textTheme.bodyMedium
              : fontScale == "small"
              ? Theme.of(context).textTheme.bodySmall
              : Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: ResponsiveUtils.responsiveFontSize(
                    AppConstants.xsmallFontSize,
                  ),
                ),
        ),
        withLeading
            ? AppNumberBg(
                fontScale: fontScale == "large"
                    ? "large"
                    : fontScale == "medium"
                    ? "medium"
                    : fontScale == "small"
                    ? "small"
                    : "x-small",
                isDark: isDark,
                rowNumber: rowNumber,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
