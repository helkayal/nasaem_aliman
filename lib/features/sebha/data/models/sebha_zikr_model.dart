class SebhaZikrModel {
  final String id;
  final String text;
  final int currentCount;
  final DateTime createdAt;
  final DateTime? lastUsedAt;

  const SebhaZikrModel({
    required this.id,
    required this.text,
    this.currentCount = 0,
    required this.createdAt,
    this.lastUsedAt,
  });

  factory SebhaZikrModel.fromJson(Map<String, dynamic> json) {
    return SebhaZikrModel(
      id: json['id'] as String,
      text: json['text'] as String,
      currentCount: json['currentCount'] as int? ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastUsedAt: json['lastUsedAt'] != null
          ? DateTime.parse(json['lastUsedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'currentCount': currentCount,
      'createdAt': createdAt.toIso8601String(),
      'lastUsedAt': lastUsedAt?.toIso8601String(),
    };
  }

  SebhaZikrModel copyWith({
    String? id,
    String? text,
    int? currentCount,
    DateTime? createdAt,
    DateTime? lastUsedAt,
  }) {
    return SebhaZikrModel(
      id: id ?? this.id,
      text: text ?? this.text,
      currentCount: currentCount ?? this.currentCount,
      createdAt: createdAt ?? this.createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }
}
