import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';

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
                    ? 50.w
                    : fontScale == "medium"
                    ? 40.w
                    : 30.w,
                height: fontScale == "large"
                    ? 50.h
                    : fontScale == "medium"
                    ? 40.h
                    : 30.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/number_bg.png'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: fontScale == "large"
                        ? AppConstants.defaultPadding * 1.h
                        : fontScale == "medium"
                        ? AppConstants.defaultPadding * .75.h
                        : AppConstants.defaultPadding * .6.h,
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
