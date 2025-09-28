// domain/entities/surah_range.dart
import 'package:equatable/equatable.dart';

class SurahRangeEntity extends Equatable {
  final int surahId;
  final String surahName;
  final int startAyah;
  final int endAyah;

  const SurahRangeEntity({
    required this.surahId,
    required this.surahName,
    required this.startAyah,
    required this.endAyah,
  });

  @override
  List<Object?> get props => [surahId, surahName, startAyah, endAyah];
}
