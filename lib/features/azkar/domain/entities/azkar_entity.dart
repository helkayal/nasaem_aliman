// domain/entities/azkar_entity.dart
import 'package:equatable/equatable.dart';

class AzkarEntity extends Equatable {
  final int id;
  final String text;
  final int count;
  final String audio;
  final String filename;

  const AzkarEntity({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  @override
  List<Object?> get props => [id, text, count, audio, filename];
}
