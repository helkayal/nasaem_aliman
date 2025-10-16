import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  final double height;
  const AppDivider({super.key, this.height = 2});

  @override
  Widget build(BuildContext context) {
    return Divider(height: height.h);
  }
}
