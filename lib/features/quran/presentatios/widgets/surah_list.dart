import 'package:flutter/material.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/surah_details_screen.dart';

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
          title: Text('${surah.id}. ${surah.nameEn}'),
          subtitle: Text(surah.name, textAlign: TextAlign.right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SurahDetailsScreen(surah: surah)),
          ),
        );
      },
    );
  }
}
