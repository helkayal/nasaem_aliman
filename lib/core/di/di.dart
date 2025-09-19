import 'package:get_it/get_it.dart';

// Quran
import 'package:nasaem_aliman/features/quran/data/datasources/quran_local_datasource.dart';
import 'package:nasaem_aliman/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:nasaem_aliman/features/quran/domain/repositories/quran_repository.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/surah_details_cubit.dart';

// UseCases
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_surahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_juz_ayahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_surah.dart';

// Azkar
import 'package:nasaem_aliman/features/azkar/presentatios/cubit/azkar_cubit.dart';

// Sebha
import 'package:nasaem_aliman/features/sebha/presentatios/cubit/sebha_cubit.dart';

// Asmaa Allah
import 'package:nasaem_aliman/features/asmaa_allah/presentatios/cubit/asmaa_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ---------------- Quran ----------------

  // Cubit
  sl.registerFactory(() => QuranCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SurahDetailsCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllSurahs(sl()));
  sl.registerLazySingleton(() => GetSurah(sl()));
  sl.registerLazySingleton(() => GetAllJuz(sl()));
  sl.registerLazySingleton(() => GetJuzAyahs(sl()));

  // Repository
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(localDataSource: sl()),
  );

  // Datasource
  sl.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSourceImpl(),
  );

  //! ---------------- Azkar ----------------
  sl.registerFactory(() => AzkarCubit());

  //! ---------------- Sebha ----------------
  sl.registerFactory(() => SebhaCubit());

  //! ---------------- Asmaa Allah Alhosna ----------------
  sl.registerFactory(() => AsmaaCubit());
}
