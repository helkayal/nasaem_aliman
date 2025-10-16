import '../../domain/entities/ayah.dart';
import '../../domain/entities/juz.dart';
import '../../domain/entities/surah.dart';
import '../../domain/entities/quran_page.dart';
import '../models/ayah_model.dart';
import '../models/juz_model.dart';
import '../models/surah_model.dart';
import '../models/quran_page_model.dart';

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

// QuranPage mappers
extension QuranPageModelMapper on QuranPageModel {
  QuranPageEntity toEntity() => QuranPageEntity(
    pageNumber: pageNumber,
    ayahs: ayahModels.map((a) => a.toEntity()).toList(),
    surahIds: surahIds,
  );
}

extension QuranPageEntityMapper on QuranPageEntity {
  QuranPageModel toModel() => QuranPageModel(
    pageNumber: pageNumber,
    ayahModels: ayahs.map((a) => a.toModel()).toList(),
    surahIds: surahIds,
  );
}
