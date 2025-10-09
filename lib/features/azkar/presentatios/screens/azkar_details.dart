import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/azkar_category_entiti.dart';
import '../widgets/azkar_list.dart';
import '../widgets/repeatable_azkar_list.dart';

class AzkarDetailsScreen extends StatelessWidget {
  final AzkarCategoryEntity category;
  const AzkarDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.category),
      body: Column(
        children: [
          Expanded(
            child: category.repeatable
                ? RepeatableAzkarList(category: category)
                : AzkarList(category: category),
          ),
        ],
      ),
    );
  }
}
