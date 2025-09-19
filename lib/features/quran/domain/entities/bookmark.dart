import 'package:flutter/material.dart';

class Bookmark {
  final String id;
  final int surahId;
  final int ayahId;
  final String name;
  final Color color;
  final bool isLastRead;

  Bookmark({
    required this.id,
    required this.surahId,
    required this.ayahId,
    required this.name,
    required this.color,
    this.isLastRead = false,
  });
}
