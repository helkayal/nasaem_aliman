import 'ayah_model.dart';

class SurahModel {
  final int id;
  final String name;
  final int versesCount;
  final List<AyahModel> ayahModels;

  SurahModel({
    required this.id,
    required this.name,
    required this.versesCount,
    required this.ayahModels,
  });

  /// From `surahs.json` (list of surah info, without ayahs)
  factory SurahModel.fromSurahListJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'] as int,
      name: (json['name'] as String?) ?? (json['name_arabic'] as String? ?? ''),
      versesCount: (json['verses_count'] as int?) ?? 0,
      ayahModels: const [],
    );
  }

  /// From `quran.json` (surah with ayahs)
  factory SurahModel.fromQuranJson(Map<String, dynamic> json) {
    final surahId = json['id'] as int;
    final ayahs = (json['ayahs'] as List)
        .map((a) => AyahModel.fromJson(a as Map<String, dynamic>, surahId))
        .toList();

    return SurahModel(
      id: surahId,
      name: (json['name'] as String?) ?? '',
      versesCount: ayahs.length,
      ayahModels: ayahs,
    );
  }
}
