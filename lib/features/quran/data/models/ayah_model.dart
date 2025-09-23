import '../../domain/entities/ayah.dart';

class AyahModel extends AyahEntity {
  AyahModel({
    required super.id,
    required super.surahId,
    required super.number,
    required super.text,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json, int surahId) {
    return AyahModel(
      id: json['id'] as int,
      surahId: surahId,
      number: json['id'] as int,
      text: json['ar'] as String,
    );
  }
}
