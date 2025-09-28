// data/models/azkar_model.dart

class AzkarModel {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  const AzkarModel({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      id: json['id'] as int,
      text: json['text'] as String,
      count: (json['count'] as int?) ?? 1,
      audio: (json['audio'] as String?) ?? '',
      filename: (json['filename'] as String?) ?? '',
    );
  }
}
