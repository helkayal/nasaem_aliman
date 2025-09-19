import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/core/di/di.dart';
import 'package:nasaem_aliman/core/widgets/app_error.dart';
import 'package:nasaem_aliman/core/widgets/app_loading.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/juz_list.dart';

class JuzaTab extends StatelessWidget {
  const JuzaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuranCubit>()..fetchAllJuz(),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is JuzLoading) {
            return const AppLoading();
          } else if (state is QuranError) {
            return AppError(message: state.message);
          } else if (state is JuzListLoaded) {
            return JuzasList(juzList: state.juzList);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
