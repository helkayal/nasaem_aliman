import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/azkar_category_entiti.dart';

class AzkarRow extends StatelessWidget {
  final AzkarCategoryEntity category;
  const AzkarRow({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/number_bg.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                category.azkar.length.toString(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Expanded(
            child: Text(
              category.category,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.right,
            ),
          ),
          Icon(Icons.star, color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
