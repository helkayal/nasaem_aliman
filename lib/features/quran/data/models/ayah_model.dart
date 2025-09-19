import '../../domain/entities/ayah.dart';

class AyahModel extends Ayah {
  AyahModel({
    required super.id,
    required super.textAr,
    required super.textEn,
    required super.audioPath,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      id: json['id'],
      textAr: json['ar'],
      textEn: json['en'],
      audioPath: json['path'],
    );
  }
}
