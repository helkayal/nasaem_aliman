import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/ayah_model.dart';
import '../models/page_entry_model.dart';
import '../models/surah_model.dart';
import '../models/juz_model.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getAllSurahs();
  Future<SurahModel> getSurah(int id);
  Future<List<JuzModel>> getAllJuz();
  Future<List<AyahModel>> getSurahAyahs(int surahId);
  Future<List<AyahModel>> getJuzAyahs(int juzId);
  Future<Map<int, List<AyahModel>>> groupAyahsByPage(
    List<AyahModel> ayahs,
    int surahNumber,
  );
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  static const String bookmarksKey = "BOOKMARKS";
  static const String lastReadKey = "LAST_READ";

  @override
  Future<List<SurahModel>> getAllSurahs() async {
    final response = await rootBundle.loadString("assets/data/surahs.json");
    final List data = json.decode(response);
    return data.map((e) => SurahModel.fromSurahListJson(e)).toList();
  }

  @override
  Future<SurahModel> getSurah(int surahId) async {
    final data = await rootBundle.loadString("assets/data/quran.json");
    final List<dynamic> jsonList = jsonDecode(data);

    final surahJson = jsonList.firstWhere((s) => s['id'] == surahId);
    return SurahModel.fromQuranJson(surahJson);
  }

  @override
  Future<List<JuzModel>> getAllJuz() async {
    final response = await rootBundle.loadString("assets/data/juzaa.json");
    final List data = json.decode(response);
    return data.map((e) => JuzModel.fromJson(e)).toList();
  }

  /// 🔹 Get all ayahs of a surah
  @override
  Future<List<AyahModel>> getSurahAyahs(int surahId) async {
    final surah = await getSurah(surahId);
    return surah.ayahModels; // ✅ ensures List<AyahModel>
  }

  /// 🔹 Get all ayahs of a juz
  @override
  Future<List<AyahModel>> getJuzAyahs(int juzId) async {
    final allJuz = await getAllJuz();
    final juz = allJuz.firstWhere((j) => j.id == juzId);

    final ayahs = <AyahModel>[];
    for (var range in juz.surahRanges) {
      final surah = await getSurah(range.surahId);
      ayahs.addAll(
        surah.ayahModels.where(
          (a) => a.number >= range.startAyah && a.number <= range.endAyah,
        ),
      );
    }
    return ayahs;
  }

  /// 🔹 Group ayahs by page using pages.json
  @override
  Future<Map<int, List<AyahModel>>> groupAyahsByPage(
    List<AyahModel> ayahs,
    int surahNumber,
  ) async {
    final String jsonStr = await rootBundle.loadString(
      'assets/data/pages.json',
    );
    final List<dynamic> jsonList = json.decode(jsonStr);

    final pageMappings = jsonList
        .map((e) => PageEntryModel.fromJson(e))
        .where((e) => e.suraNumber == surahNumber)
        .toList();

    final Map<int, List<AyahModel>> pages = {};

    for (final mapping in pageMappings) {
      final ayah = ayahs.firstWhere(
        (a) => a.number == mapping.ayahNumber,
        orElse: () => AyahModel(id: 0, surahId: 0, number: 0, text: ''),
      );
      if (ayah.number == 0) continue;

      pages.putIfAbsent(mapping.pageNumber, () => []).add(ayah);
    }

    return pages;
  }
}
