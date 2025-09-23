import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/usecases/group_ayas_per_page.dart';
import 'ayahs_state.dart';

class AyahsCubit extends Cubit<AyahsStates> {
  final GroupAyahsByPage groupAyahsByPage;

  AyahsCubit(this.groupAyahsByPage) : super(AyahStateInitial());

  Future<void> fetchAyahsByPage(List<AyahEntity> ayahs, int surahNumber) async {
    emit(AyahStateLoading());
    try {
      final groupedAyahs = await groupAyahsByPage(ayahs, surahNumber);
      emit(AyahStateLoaded(groupedAyahs));
    } catch (e) {
      emit(AyahStateError(e.toString()));
    }
  }
}
