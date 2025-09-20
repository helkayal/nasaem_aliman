import 'package:nasaem_aliman/features/quran/data/models/ayah_model.dart';

abstract class AyahsStates {}

class AyahStateInitial extends AyahsStates {}

class AyahStateLoading extends AyahsStates {}

class AyahStateLoaded extends AyahsStates {
  final Map<int, List<AyahModel>> ayahs;
  AyahStateLoaded(this.ayahs);
}

class AyahStateError extends AyahsStates {
  final String message;
  AyahStateError(this.message);
}
