import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../domain/entities/surah.dart';
import '../cubit/surah_details_cubit.dart';
import '../screens/surah_details_screen.dart';

class SurahsList extends StatelessWidget {
  final List<Surah> surahsList;
  const SurahsList({super.key, required this.surahsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahsList.length,
      itemBuilder: (context, i) {
        final Surah surah = surahsList[i];
        return ListTile(
          title: Text('${surah.id}. ${surah.name}'),
          subtitle: Text(surah.name, textAlign: TextAlign.right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => sl<SurahDetailsCubit>(),
                  child: SurahDetailsScreen(surahId: surah.id),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
