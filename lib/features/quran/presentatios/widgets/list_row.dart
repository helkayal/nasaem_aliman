import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';

import '../../../../core/constants/app_assets.dart';

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
              : Theme.of(context).textTheme.bodySmall,
        ),
        withLeading
            ? Container(
                width: fontScale == "large"
                    ? 52.w
                    : fontScale == "medium"
                    ? 46.w
                    : 40.w,
                height: fontScale == "large"
                    ? 52.h
                    : fontScale == "medium"
                    ? 46.h
                    : 40.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      isDark ? AppAssets.numberBgDark : AppAssets.numberBg,
                    ),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: fontScale == "large"
                        ? AppConstants.defaultPadding * 1.2.h
                        : fontScale == "medium"
                        ? AppConstants.defaultPadding * .9.h
                        : AppConstants.defaultPadding * .8.h,
                  ),
                  child: Text(
                    rowNumber,
                    textAlign: TextAlign.center,
                    style: fontScale == "large"
                        ? Theme.of(context).textTheme.bodyLarge
                        : fontScale == "medium"
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
