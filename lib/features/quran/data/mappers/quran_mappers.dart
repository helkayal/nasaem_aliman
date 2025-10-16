import '../../domain/entities/ayah.dart';
import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../models/ayah_model.dart';
import '../models/juz_model.dart';
import '../models/surah_model.dart';

// Ayah mappers
extension AyahModelMapper on AyahModel {
  AyahEntity toEntity() =>
      AyahEntity(id: id, surahId: surahId, number: number, text: text);
}

extension AyahEntityMapper on AyahEntity {
  AyahModel toModel() =>
      AyahModel(id: id, surahId: surahId, number: number, text: text);
}

// Surah mappers
extension SurahModelMapper on SurahModel {
  // Build a domain entity copying scalar fields and mapping ayahs
  // Note: SurahEntity holds List<AyahEntity>
  // SurahModel keeps List<AyahModel> in ayahModels
  SurahEntity toEntity() => SurahEntity(
    id: id,
    name: name,
    versesCount: versesCount,
    revelationType: revelationType,
    pages: pages,
    ayahs: ayahModels.map((a) => a.toEntity()).toList(),
  );
}

// Juz mappers
extension JuzModelMapper on JuzModel {
  JuzEntity toEntity() => JuzEntity(
    id: id,
    name: name,
    surahRanges: surahRanges, // already domain type
  );
}
