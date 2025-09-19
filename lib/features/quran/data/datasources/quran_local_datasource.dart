import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/surah_model.dart';
import '../models/juz_model.dart';
import '../models/bookmark_model.dart';

abstract class QuranLocalDataSource {
  Future<List<SurahModel>> getAllSurahs();
  Future<SurahModel> getSurah(int id);
  Future<List<JuzModel>> getAllJuz();
  Future<List<JuzModel>> getJuz();
  Future<List<BookmarkModel>> getBookmarks();
  Future<void> saveBookmarks(List<BookmarkModel> bookmarks);
}

class QuranLocalDataSourceImpl implements QuranLocalDataSource {
  // static const _bookmarkKey = "BOOKMARKS";

  @override
  Future<List<SurahModel>> getAllSurahs() async {
    final String response = await rootBundle.loadString(
      "assets/data/quran.json",
    );
    final List data = json.decode(response);
    return data.map((e) => SurahModel.fromJson(e)).toList();
  }

  @override
  Future<SurahModel> getSurah(int id) async {
    final surahs = await getAllSurahs();
    return surahs.firstWhere((s) => s.id == id);
  }

  @override
  Future<List<JuzModel>> getAllJuz() async {
    final String response = await rootBundle.loadString(
      "assets/data/juzaa.json",
    );
    final List data = json.decode(response);
    return data.map((e) => JuzModel.fromJson(e)).toList();
  }

  @override
  Future<List<JuzModel>> getJuz() async {
    final String response = await rootBundle.loadString(
      'assets/data/juzaa.json',
    );
    final List<dynamic> data = json.decode(response);

    return data.map((j) => JuzModel.fromJson(j)).toList();
  }

  @override
  Future<List<BookmarkModel>> getBookmarks() async {
    return [];
  }

  @override
  Future<void> saveBookmarks(List<BookmarkModel> bookmarks) async {}
}
