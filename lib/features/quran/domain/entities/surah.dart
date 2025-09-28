import 'package:equatable/equatable.dart';
import 'ayah.dart';

class SurahEntity extends Equatable {
  final int id;
  final String name; // Arabic name
  final int versesCount; // from surahs.json
  final List<AyahEntity> ayahs;

  const SurahEntity({
    required this.id,
    required this.name,
    required this.versesCount,
    required this.ayahs,
  });

  @override
  List<Object?> get props => [id, name, versesCount, ayahs];
}
