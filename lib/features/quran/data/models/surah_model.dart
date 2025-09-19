import '../../domain/entities/surah.dart';
import 'ayah_model.dart';

class SurahModel extends Surah {
  SurahModel({
    required super.id,
    required super.name,
    required super.nameEn,
    required super.nameTranslation,
    required super.bismillahPre,
    required super.words,
    required super.letters,
    required super.pages,
    required super.type,
    required super.ayahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      nameTranslation: json['name_translation'] ?? '',
      bismillahPre: json['bismillah_pre'] ?? false,
      words: json['words'] ?? 0,
      letters: json['letters'] ?? 0,
      pages: json['pages'] != null ? List<int>.from(json['pages']) : [],
      type: json['type'] ?? '',
      ayahs:
          (json['ayahs'] as List<dynamic>?)
              ?.map((e) => AyahModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
