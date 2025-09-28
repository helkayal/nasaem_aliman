// Strip metadata fields from per-surah JSON files, keeping only { id, ayahs }
// Usage: dart run tool/strip_surah_files.dart

import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final dir = Directory('assets/data/surahs');
  if (!await dir.exists()) {
    stderr.writeln('Directory not found: ${dir.path}');
    exit(1);
  }
  final files =
      (await dir
              .list()
              .where((e) => e is File && e.path.endsWith('.json'))
              .toList())
          .cast<File>();
  int updated = 0;
  for (final file in files) {
    try {
      final raw = await file.readAsString();
      final Map<String, dynamic> jsonMap =
          jsonDecode(raw) as Map<String, dynamic>;
      final id = jsonMap['id'];
      final ayahs = jsonMap['ayahs'];
      if (id == null || ayahs == null || ayahs is! List) {
        stderr.writeln('Skipping ${file.path}: missing id or ayahs');
        continue;
      }
      final minimal = {'id': id, 'ayahs': ayahs};
      final encoder = const JsonEncoder.withIndent('  ');
      await file.writeAsString('${encoder.convert(minimal)}\n');
      updated++;
    } catch (e) {
      stderr.writeln('Failed to process ${file.path}: $e');
    }
  }
  stdout.writeln('✔ Stripped $updated surah files in ${dir.path}');
}
