import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/ayah_model.dart';
import '../../domain/usecases/group_ayas_per_page.dart';
import 'ayahs_state.dart';

class AyahsCubit extends Cubit<AyahsStates> {
  final GroupAyahsByPage groupAyahsByPage;

  AyahsCubit({required this.groupAyahsByPage}) : super(AyahStateInitial());

  Future<void> fetchAyahsByPage(List<AyahModel> ayahs, int surahNumber) async {
    emit(AyahStateLoading());
    try {
      final groupedAyahs = await groupAyahsByPage(ayahs, surahNumber);
      emit(AyahStateLoaded(groupedAyahs));
    } catch (e) {
      emit(AyahStateError(e.toString()));
    }
  }
}
