import 'package:flutter/material.dart';

import '../../../../core/widgets/app_divider.dart';
import '../../domain/entities/azkar_category_entiti.dart';

class AzkarList extends StatelessWidget {
  const AzkarList({super.key, required this.category});
  final AzkarCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: category.azkar.length,
      separatorBuilder: (_, __) => const AppDivider(),
      itemBuilder: (context, index) {
        final zekr = category.azkar[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            zekr.text,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 2),
          ),
        );
      },
    );
  }
}
