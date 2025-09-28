class AyahModel {
  final int id; // ayah id within surah (1..N)
  final int surahId; // parent surah id
  final int number; // same as id
  final String text; // Arabic text (from 'ar')

  AyahModel({
    required this.id,
    required this.surahId,
    required this.number,
    required this.text,
  });

  factory AyahModel.fromJson(Map<String, dynamic> json, int surahId) {
    final id = json['id'] as int;
    return AyahModel(
      id: id,
      surahId: surahId,
      number: id,
      text: (json['ar'] as String?) ?? (json['text'] as String? ?? ''),
    );
  }
}
