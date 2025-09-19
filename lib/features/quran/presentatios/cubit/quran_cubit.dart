import '../../domain/entities/surah.dart';
import '../../domain/usecases/get_juz_ayahs.dart';
import '../../domain/usecases/get_surah.dart';
import 'quran_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_all_surahs.dart';
import '../../domain/usecases/get_all_juz.dart';

class QuranCubit extends Cubit<QuranState> {
  final GetAllSurahs getAllSurahs;
  final GetSurah getSurah;
  final GetAllJuz getAllJuz;
  final GetJuzAyahs getJuzAyahs;

  QuranCubit(this.getSurah, this.getJuzAyahs, this.getAllSurahs, this.getAllJuz)
    : super(QuranInitial());

  // ---------------- Surahs ----------------
  Future<void> fetchAllSurahs() async {
    emit(SurahListLoading());
    try {
      final surahs = await getAllSurahs();
      emit(SurahListLoaded(surahs));
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }

  // Future<void> fetchSurah(int id) async {
  //   emit(SurahLoading());
  //   try {
  //     final surah = await getSurah(id);
  //     emit(SurahLoaded(surah));
  //   } catch (e) {
  //     emit(QuranError(e.toString()));
  //   }
  // }

  // ---------------- Juz ----------------
  Future<void> fetchAllJuz() async {
    emit(QuranLoading());
    try {
      final juzList = await getAllJuz();
      emit(JuzListLoaded(juzList));
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }

  Future<void> fetchJuzAyahs(int id) async {
    emit(QuranLoading());
    try {
      final ayahs = await getJuzAyahs(id);
      emit(JuzAyahsLoaded(id, ayahs));
    } catch (e) {
      emit(QuranError(e.toString()));
    }
  }

  // ---------------- Helpers ----------------
  Surah? findSurahById(int surahId) {
    if (state is SurahListLoaded) {
      final surahs = (state as SurahListLoaded).surahs;
      try {
        return surahs.firstWhere((s) => s.id == surahId);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
