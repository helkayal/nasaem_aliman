// data/models/juz_model.dart
import '../../domain/entities/juz.dart';
import '../../domain/entities/surah_range.dart';

class JuzModel extends JuzEntity {
  JuzModel({
    required super.id,
    required super.name,
    required super.surahRanges,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) {
    return JuzModel(
      id: json['number'] as int,
      name: json['name'] as String,
      surahRanges: (json['surahs'] as List)
          .map(
            (s) => SurahRangeEntity(
              surahId: s['sura'] as int,
              surahName: s['sura_name'] as String,
              startAyah: s['aya'][0] as int,
              endAyah: s['aya'][1] as int,
            ),
          )
          .toList(),
    );
  }
}
