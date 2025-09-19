import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../domain/entities/juz.dart';
import '../cubit/surah_details_cubit.dart';
import '../screens/surah_details_screen.dart';

class JuzasList extends StatelessWidget {
  final List<Juz> juzList;
  const JuzasList({super.key, required this.juzList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: juzList.length,
      itemBuilder: (context, i) {
        final juz = juzList[i];
        return ExpansionTile(
          title: Text(
            juz.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          subtitle: Text(
            juz.surahRanges
                .map((s) => "${s.surahName} (${s.startAyah}–${s.endAyah})")
                .join("، "),
            textAlign: TextAlign.right,
          ),
          children: juz.surahRanges.map((range) {
            return ListTile(
              title: Text(range.surahName, textAlign: TextAlign.right),
              subtitle: Text(
                "من آية ${range.startAyah} إلى ${range.endAyah}",
                textAlign: TextAlign.right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => sl<SurahDetailsCubit>(),
                      child: SurahDetailsScreen(
                        surahId: range.surahId,
                        scrollToAyah: range.startAyah,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
