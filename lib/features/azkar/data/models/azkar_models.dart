// data/models/azkar_model.dart

import '../../domain/entities/azkar_entity.dart';

class AzkarModel extends AzkarEntity {
  const AzkarModel({
    required super.id,
    required super.text,
    required super.count,
    required super.audio,
    required super.filename,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      audio: json['audio'] ?? "",
      filename: json['filename'] ?? "",
    );
  }
}
