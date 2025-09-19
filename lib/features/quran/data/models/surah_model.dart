import '../../domain/entities/surah.dart';
import 'ayah_model.dart';

class SurahModel extends Surah {
  SurahModel({
    required super.id,
    required super.name,
    required super.versesCount,
    required super.ayahs,
  });

  /// From `surahs.json` (list of surah info, without ayahs)
  factory SurahModel.fromSurahListJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'] as int,
      name: json['name_arabic'] as String,
      versesCount: json['verses_count'] as int,
      ayahs: [], // no ayahs in this file
    );
  }

  /// From `quran.json` (surah with ayahs)
  factory SurahModel.fromQuranJson(Map<String, dynamic> json) {
    final surahId = json['id'] as int;
    return SurahModel(
      id: surahId,
      name: json['name'] as String,
      versesCount: (json['ayahs'] as List).length,
      ayahs: (json['ayahs'] as List)
          .map((a) => AyahModel.fromJson(a, surahId))
          .toList(),
    );
  }
}
