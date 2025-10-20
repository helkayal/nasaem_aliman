import 'package:equatable/equatable.dart';
import '../../domain/entities/sebha_zikr_entity.dart';

abstract class SebhaState extends Equatable {
  const SebhaState();

  @override
  List<Object?> get props => [];
}

class SebhaInitial extends SebhaState {}

class SebhaLoading extends SebhaState {}

class SebhaLoaded extends SebhaState {
  final List<SebhaZikrEntity> savedAzkar;
  final SebhaZikrEntity? currentZikr;
  final int currentIndex;

  const SebhaLoaded({
    required this.savedAzkar,
    this.currentZikr,
    this.currentIndex = 0,
  });

  SebhaLoaded copyWith({
    List<SebhaZikrEntity>? savedAzkar,
    SebhaZikrEntity? currentZikr,
    int? currentIndex,
    bool clearCurrentZikr = false,
  }) {
    return SebhaLoaded(
      savedAzkar: savedAzkar ?? this.savedAzkar,
      currentZikr: clearCurrentZikr ? null : (currentZikr ?? this.currentZikr),
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [savedAzkar, currentZikr, currentIndex];
}

class SebhaError extends SebhaState {
  final String message;

  const SebhaError(this.message);

  @override
  List<Object?> get props => [message];
}
