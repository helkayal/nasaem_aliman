import 'package:flutter/material.dart';

import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_number_bg.dart';
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
          AppNumberBg(
            fontScale: "medium",
            isDark: Theme.of(context).brightness == Brightness.dark,
            rowNumber: NumberConverter.intToArabic(category.azkar.length),
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
