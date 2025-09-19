import 'package:nasaem_aliman/features/quran/domain/entities/juz.dart';

class JuzModel extends Juz {
  JuzModel({
    required super.number,
    required super.name,
    required List<JuzSurahModel> super.surahs,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) {
    return JuzModel(
      number: json['number'] ?? 0,
      name: json['name'] ?? '',
      surahs:
          (json['surahs'] as List<dynamic>?)
              ?.map((e) => JuzSurahModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class JuzSurahModel extends JuzSurah {
  JuzSurahModel({
    required super.sura,
    required super.suraName,
    required super.aya,
  });

  factory JuzSurahModel.fromJson(Map<String, dynamic> json) {
    return JuzSurahModel(
      sura: json['sura'] ?? 0,
      suraName: json['sura_name'] ?? '',
      aya: json['aya'] != null ? List<int>.from(json['aya']) : [],
    );
  }
}
