import 'ayah_model.dart';

class QuranPageModel {
  final int pageNumber;
  final List<AyahModel> ayahModels;
  final Set<int> surahIds;

  QuranPageModel({
    required this.pageNumber,
    required this.ayahModels,
    required this.surahIds,
  });

  // Factory constructor from grouped ayahs
  factory QuranPageModel.fromAyahsGroup({
    required int pageNumber,
    required List<AyahModel> ayahs,
  }) {
    final surahIds = ayahs.map((ayah) => ayah.surahId).toSet();
    return QuranPageModel(
      pageNumber: pageNumber,
      ayahModels: ayahs,
      surahIds: surahIds,
    );
  }
}
