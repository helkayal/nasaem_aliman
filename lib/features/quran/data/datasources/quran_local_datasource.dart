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
  Map<int, String>? _surahNamesCache;

  Future<Map<int, String>> _loadSurahNames() async {
    if (_surahNamesCache != null) return _surahNamesCache!;
    final response = await rootBundle.loadString("assets/data/surahs.json");
    final List data = json.decode(response);
    _surahNamesCache = {
      for (final e in data)
        (e['id'] as int):
            (e['name'] as String?) ?? (e['name_arabic'] as String? ?? ''),
    };
    return _surahNamesCache!;
  }

  @override
  Future<List<SurahModel>> getAllSurahs() async {
    final response = await rootBundle.loadString("assets/data/surahs.json");
    final List data = json.decode(response);
    return data.map((e) => SurahModel.fromSurahListJson(e)).toList();
  }

  @override
  Future<SurahModel> getSurah(int surahId) async {
    // Prefer per-surah file: assets/data/surahs/NNN.json
    final fileName = surahId.toString().padLeft(3, '0');
    final path = "assets/data/surahs/$fileName.json";
    final raw = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = jsonDecode(raw);

    final List<dynamic> ayahsJson = (jsonMap['ayahs'] as List<dynamic>);
    final ayahModels = ayahsJson
        .map((a) => AyahModel.fromJson(a as Map<String, dynamic>, surahId))
        .toList();

    final names = await _loadSurahNames();
    final String name = names[surahId] ?? '';
    return SurahModel(
      id: surahId,
      name: name,
      versesCount: ayahModels.length,
      ayahModels: ayahModels,
    );
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
