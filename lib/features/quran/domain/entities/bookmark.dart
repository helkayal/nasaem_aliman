class Bookmark {
  final int id;
  final int surahId;
  final int ayahId;
  final String name;
  final int color;
  final bool isLastRead;

  Bookmark({
    required this.id,
    required this.surahId,
    required this.ayahId,
    required this.name,
    required this.color,
    required this.isLastRead,
  });
}
