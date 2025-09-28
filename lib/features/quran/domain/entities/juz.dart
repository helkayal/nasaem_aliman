import 'package:equatable/equatable.dart';
import 'surah_range.dart';

class JuzEntity extends Equatable {
  final int id;
  final String name;
  final List<SurahRangeEntity> surahRanges;

  const JuzEntity({
    required this.id,
    required this.name,
    required this.surahRanges,
  });

  @override
  List<Object?> get props => [id, name, surahRanges];
}
