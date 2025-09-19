import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor,
      height: 8.h,
      thickness: 1.5,
      indent: MediaQuery.of(context).size.width * .1,
      endIndent: MediaQuery.of(context).size.width * .1,
    );
  }
}
