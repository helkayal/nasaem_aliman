import 'package:flutter/material.dart';

import '../../../../core/utils/number_converter.dart';
import '../../../../core/utils/icon_converter.dart';
import '../../domain/entities/azkar_category_entity.dart';

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
          SizedBox(width: 8),
          Text(
            '${NumberConverter.intToArabic(category.azkar.length)} ${_getAzkarText(category.azkar.length)}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Expanded(
            child: Text(
              category.category,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.right,
            ),
          ),
          Icon(
            IconConverter.fromString(category.icon),
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  String _getAzkarText(int count) {
    if (count <= 10 && count > 2) {
      return 'اذكار';
    } else {
      return 'ذكر';
    }
  }
}
