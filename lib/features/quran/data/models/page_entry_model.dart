import '../../domain/entities/page_entry.dart';

class PageEntryModel extends PageEntry {
  PageEntryModel({
    required super.ayahNumber,
    required super.suraNumber,
    required super.pageNumber,
  });

  factory PageEntryModel.fromJson(Map<String, dynamic> json) {
    return PageEntryModel(
      ayahNumber: json['ayah_number'] as int,
      suraNumber: json['sura_number'] as int,
      pageNumber: json['page_number'] as int,
    );
  }
}
