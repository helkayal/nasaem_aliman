// data/models/juz_model.dart
import '../../domain/entities/surah_range.dart';

class JuzModel {
  final int id;
  final String name;
  final List<SurahRangeEntity> surahRanges;

  JuzModel({required this.id, required this.name, required this.surahRanges});

  factory JuzModel.fromJson(Map<String, dynamic> json) {
    return JuzModel(
      id: json['number'] as int,
      name: json['name'] as String,
      surahRanges: (json['surahs'] as List)
          .map(
            (s) => SurahRangeEntity(
              surahId: s['sura'] as int,
              surahName: s['sura_name'] as String,
              startAyah: (s['aya'] as List)[0] as int,
              endAyah: (s['aya'] as List)[1] as int,
            ),
          )
          .toList(),
    );
  }
}
