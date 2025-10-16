import 'package:equatable/equatable.dart';
import 'ayah.dart';

class SurahEntity extends Equatable {
  final int id;
  final String name; // Arabic name
  final int versesCount; // from surahs.json
  final String revelationType; // مكية or مدنية
  final List<int> pages; // start and end pages
  final List<AyahEntity> ayahs;

  const SurahEntity({
    required this.id,
    required this.name,
    required this.versesCount,
    required this.revelationType,
    required this.pages,
    required this.ayahs,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    versesCount,
    revelationType,
    pages,
    ayahs,
  ];
}
