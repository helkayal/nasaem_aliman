import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/core/di/di.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/surah_details_screen.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuranCubit>()..fetchSurahs(),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SurahsLoaded) {
            return ListView.builder(
              itemCount: state.surahs.length,
              itemBuilder: (context, i) {
                final Surah s = state.surahs[i];
                return ListTile(
                  title: Text('${s.id}. ${s.nameEn}'),
                  subtitle: Text(s.name, textAlign: TextAlign.right),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurahDetailsScreen(surah: s),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
