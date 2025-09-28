// Utility script to regenerate a simplified surahs.json from quran.json
// Usage:
// dart run tool/generate_surahs_list.dart
// Output overwrites assets/data/surahs.json with the simplified structure:
// [ { id, name, bismillah_pre, words, letters, pages:[start,end], type } ]
// words = total whitespace-delimited tokens across ayahs
// letters = count of Arabic letters (remove spaces and punctuation)

import 'dart:convert';
import 'dart:io';

final arabicLetterRegex = RegExp(r'[ء-ي]');

int countLetters(String text) {
  return arabicLetterRegex.allMatches(text).length;
}

int countWords(String text) {
  // Split on whitespace; filter empty
  return text.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).length;
}

Future<void> main() async {
  final quranPath = 'assets/data/quran.json';
  final outputPath = 'assets/data/surahs.json';
  final raw = await File(quranPath).readAsString();
  final List<dynamic> quran = jsonDecode(raw);

  final simplified = <Map<String, dynamic>>[];

  for (final surah in quran) {
    final id = surah['id'] as int;
    final nameArabic = surah['name'] as String; // Arabic name
    final bismillah = surah['bismillah_pre'] as bool? ?? true;
    final pages = (surah['pages'] as List<dynamic>? ?? [0, 0]).cast<int>();

    // Prefer provided aggregated fields; fallback to computing from ayahs['ar']
    int words = (surah['words'] is int) ? surah['words'] as int : 0;
    int letters = (surah['letters'] is int) ? surah['letters'] as int : 0;
    final ayahs = surah['ayahs'] as List<dynamic>? ?? [];

    if (words == 0 || letters == 0) {
      int w = 0;
      int l = 0;
      for (final ayah in ayahs) {
        final textAr =
            (ayah['ar'] as String?) ?? (ayah['text'] as String? ?? '');
        if (textAr.isEmpty) continue;
        w += countWords(textAr);
        l += countLetters(textAr);
      }
      if (words == 0) words = w;
      if (letters == 0) letters = l;
    }

    // Use existing type keys if present; fallback derivation none (legacy code removed)
    final type = (surah['type'] as String?) ?? '';
    final typeEn = (surah['type_en'] as String?) ?? '';

    simplified.add({
      'id': id,
      'name': nameArabic,
      'bismillah_pre': bismillah,
      'words': words,
      'letters': letters,
      'pages': pages,
      'verses_count': ayahs.length,
      'type': type,
      'type_en': typeEn,
    });
  }

  // Write pretty JSON
  final encoder = const JsonEncoder.withIndent('  ');
  final jsonStr = encoder.convert(simplified);
  await File(outputPath).writeAsString('$jsonStr\n');
  stdout.writeln(
    '✔ Generated simplified surahs.json with ${simplified.length} entries',
  );
}
