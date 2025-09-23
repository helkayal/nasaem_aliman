import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../cubit/azkar_category_state.dart';
import '../cubit/azkar_category_cubit.dart';
import '../widgets/azkar_row.dart';
import 'azkar_details.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الأذكار")),
      body: BlocBuilder<AzkarCategoriesCubit, AzkarCategoriesState>(
        builder: (context, state) {
          if (state is AzkarCategoriesLoading) {
            return const AppLoading();
          } else if (state is AzkarCategoriesLoaded) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: state.categories.length,
              separatorBuilder: (_, __) => const AppDivider(),
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AzkarDetailsScreen(category: category),
                      ),
                    );
                  },
                  child: AzkarRow(category: category),
                );
              },
            );
          } else if (state is AzkarCategoriesError) {
            return Center(child: AppError(message: state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
