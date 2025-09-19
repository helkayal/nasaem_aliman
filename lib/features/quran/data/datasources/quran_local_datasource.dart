import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/ayah.dart';
import '../models/surah_model.dart';
import '../models/juz_model.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getAllSurahs();
  Future<SurahModel> getSurah(int id);
  Future<List<JuzModel>> getAllJuz();
  Future<List<Ayah>> getSurahAyahs(int surahId);
  Future<List<Ayah>> getJuzAyahs(int juzId);

  // Future<List<BookmarkModel>> getBookmarks();
  // Future<void> saveBookmark(Ayah ayah);
  // Future<void> removeBookmark(int ayahId);
  // Future<void> setLastRead(Ayah ayah);
  // Future<Ayah?> getLastRead();
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

  // 🔹 get ayahs of a surah
  @override
  Future<List<Ayah>> getSurahAyahs(int surahId) async {
    final surah = await getSurah(surahId);
    return surah.ayahs; // already List<Ayah>
  }

  @override
  Future<List<Ayah>> getJuzAyahs(int juzId) async {
    final allSurahs = await getAllSurahs();
    final allJuz = await getAllJuz();
    final juz = allJuz.firstWhere((j) => j.id == juzId);

    final ayahs = <Ayah>[];
    for (var range in juz.surahRanges) {
      final surah = allSurahs.firstWhere((s) => s.id == range.surahId);
      ayahs.addAll(
        surah.ayahs.where(
          (a) => a.number >= range.startAyah && a.number <= range.endAyah,
        ),
      );
    }
    return ayahs;
  }

  // @override
  // Future<List<BookmarkModel>> getBookmarks() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final data = prefs.getStringList(bookmarksKey) ?? [];
  //   return data.map((e) => BookmarkModel.fromJson(jsonDecode(e))).toList();
  // }

  // @override
  // Future<void> saveBookmark(Ayah ayah) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final bookmarks = prefs.getStringList(bookmarksKey) ?? [];
  //   bookmarks.add(jsonEncode(ayah.toJson()));
  //   await prefs.setStringList(bookmarksKey, bookmarks);
  // }

  // @override
  // Future<void> removeBookmark(int ayahId) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final bookmarks = prefs.getStringList(bookmarksKey) ?? [];
  //   final updated = bookmarks.where((b) {
  //     final map = jsonDecode(b);
  //     return map['id'] != ayahId;
  //   }).toList();
  //   await prefs.setStringList(bookmarksKey, updated);
  // }

  // @override
  // Future<void> setLastRead(Ayah ayah) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(lastReadKey, jsonEncode(ayah.toJson()));
  // }

  // @override
  // Future<Ayah?> getLastRead() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final data = prefs.getString(lastReadKey);
  //   if (data == null) return null;
  //   final map = jsonDecode(data);
  //   return Ayah.fromJson(map);
  // }
}
