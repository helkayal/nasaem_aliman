import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_surah.dart';
import 'surah_details_state.dart';

class SurahDetailsCubit extends Cubit<SurahDetailsState> {
  final GetSurah getSurah;

  SurahDetailsCubit(this.getSurah) : super(SurahDetailsInitial());

  Future<void> fetchSurah(int id) async {
    emit(SurahDetailsLoading());
    try {
      final surah = await getSurah(id);
      emit(SurahDetailsLoaded(surah));
    } catch (e) {
      emit(SurahDetailsError(e.toString()));
    }
  }
}
