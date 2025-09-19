import 'package:flutter/material.dart';
import '../../domain/entities/bookmark.dart';

class BookmarkModel extends Bookmark {
  BookmarkModel({
    required super.id,
    required super.surahId,
    required super.ayahId,
    required super.name,
    required super.color,
    super.isLastRead,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "surahId": surahId,
    "ayahId": ayahId,
    "name": name,
    "color": color,
    "isLastRead": isLastRead,
  };

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'],
      surahId: json['surahId'],
      ayahId: json['ayahId'],
      name: json['name'],
      color: Color(json['color']),
      isLastRead: json['isLastRead'] ?? false,
    );
  }
}
