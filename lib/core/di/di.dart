import 'package:get_it/get_it.dart';
import 'package:nasaem_aliman/features/azkar/data/datasources/azkar_category_local_datasource.dart';
import 'package:nasaem_aliman/features/azkar/data/repositories/azkar_category_repository_impl.dart';
import 'package:nasaem_aliman/features/azkar/domain/repositories/azkar_category_repository.dart';
import 'package:nasaem_aliman/features/azkar/domain/usecases/get_azkar_categories.dart';

// Quran
import 'package:nasaem_aliman/features/quran/data/datasources/quran_local_datasource.dart';
import 'package:nasaem_aliman/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:nasaem_aliman/features/quran/domain/repositories/quran_repository.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/ayahs_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/surah_details_cubit.dart';

// UseCases
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_surahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_juz_ayahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_surah.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/group_ayas_per_page.dart';

// Azkar
import 'package:nasaem_aliman/features/azkar/presentatios/cubit/azkar_category_cubit.dart';

// Sebha
import 'package:nasaem_aliman/features/sebha/cubit/sebha_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ---------------- Quran ----------------

  // Cubit
  sl.registerFactory(() => QuranCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SurahDetailsCubit(sl()));
  sl.registerFactory(() => AyahsCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllSurahs(sl()));
  sl.registerLazySingleton(() => GetSurah(sl()));
  sl.registerLazySingleton(() => GetAllJuz(sl()));
  sl.registerLazySingleton(() => GetJuzAyahs(sl()));
  sl.registerLazySingleton(() => GroupAyahsByPage(sl()));

  // Repository
  sl.registerLazySingleton<QuranRepository>(
    () => QuranRepositoryImpl(localDataSource: sl()),
  );

  // Datasource
  sl.registerLazySingleton<QuranLocalDataSource>(
    () => QuranLocalDataSourceImpl(),
  );

  //! ---------------- Azkar ----------------

  // Cubit
  sl.registerFactory(() => AzkarCategoriesCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAzkarCategories(sl()));

  // Repository
  sl.registerLazySingleton<AzkarCategoriesRepository>(
    () => AzkarCategoriesRepositoryImpl(sl()),
  );

  // Datasource
  sl.registerLazySingleton<AzkarCategoriesLocalDataSource>(
    () => AzkarCategoriesLocalDataSourceImpl(),
  );

  //! ---------------- Sebha ----------------
  sl.registerFactory(() => SebhaCubit());
}
