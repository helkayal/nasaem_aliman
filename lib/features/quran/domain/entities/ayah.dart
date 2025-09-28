import 'package:equatable/equatable.dart';

class AyahEntity extends Equatable {
  final int id; // from quran.json
  final int surahId; // link to surah
  final int number; // sequential number within surah
  final String text; // Arabic text

  const AyahEntity({
    required this.id,
    required this.surahId,
    required this.number,
    required this.text,
  });

  @override
  List<Object?> get props => [id, surahId, number, text];
}
