import 'package:equatable/equatable.dart';

class SebhaZikrEntity extends Equatable {
  final String id;
  final String text;
  final int currentCount;
  final DateTime createdAt;
  final DateTime? lastUsedAt;

  const SebhaZikrEntity({
    required this.id,
    required this.text,
    this.currentCount = 0,
    required this.createdAt,
    this.lastUsedAt,
  });

  SebhaZikrEntity copyWith({
    String? id,
    String? text,
    int? currentCount,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  }) {
    return SebhaZikrEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      currentCount: currentCount ?? this.currentCount,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  List<Object?> get props => [id, text, currentCount, createdAt, lastUsedAt];
}
