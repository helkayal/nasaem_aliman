import '../../domain/entities/ayah.dart';

abstract class AyahsStates {}

class AyahStateInitial extends AyahsStates {}

class AyahStateLoading extends AyahsStates {}

class AyahStateLoaded extends AyahsStates {
  final Map<int, List<AyahEntity>> ayahs;
  AyahStateLoaded(this.ayahs);
}

class AyahStateError extends AyahsStates {
  final String message;
  AyahStateError(this.message);
}
