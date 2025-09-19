import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/juz.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/surah_details_screen.dart';

class JuzasList extends StatelessWidget {
  final List<Juz> juzList;
  const JuzasList({super.key, required this.juzList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: juzList.length,
      itemBuilder: (context, i) {
        // inside ListView.builder for Juz (state is JuzLoaded)
        final juz = juzList[i];
        return ExpansionTile(
          title: Text(
            juz.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: juz.surahs.isNotEmpty
              ? Text(
                  juz.surahs
                      .map(
                        (s) => "${s.suraName} (${s.aya.first}–${s.aya.last})",
                      )
                      .join(", "),
                )
              : const Text("⚠️ No surahs found"),
          children: juz.surahs.map((jSurah) {
            return ListTile(
              title: Text(jSurah.suraName, textAlign: TextAlign.right),
              subtitle: Text("Ayah ${jSurah.aya.first} - ${jSurah.aya.last}"),
              onTap: () async {
                final cubit = context.read<QuranCubit>();

                // Try to find cached Surah
                final surah = cubit.findSurahById(jSurah.sura);
                if (surah != null) {
                  // We already have the Surah loaded -> push with full Surah
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SurahDetailsScreen(
                        surah: surah,
                        scrollToAyah: jSurah.aya.first,
                      ),
                    ),
                  );
                  return;
                }

                // fallback: let SurahDetailsScreen fetch the surah by id
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SurahDetailsScreen(
                      surahId: jSurah.sura,
                      scrollToAyah: jSurah.aya.first,
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
