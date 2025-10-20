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
import 'package:nasaem_aliman/features/quran/domain/usecases/get_quran_pages.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_page_for_surah.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_page_for_juz_surah.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_pages_view_cubit.dart';

// Azkar
import 'package:nasaem_aliman/features/azkar/presentatios/cubit/azkar_category_cubit.dart';

// Sebha
import 'package:nasaem_aliman/features/sebha/data/datasources/sebha_local_datasource.dart';
import 'package:nasaem_aliman/features/sebha/data/repositories/sebha_repository_impl.dart';
import 'package:nasaem_aliman/features/sebha/domain/repositories/sebha_repository.dart';
import 'package:nasaem_aliman/features/sebha/domain/usecases/sebha_usecases.dart';
import 'package:nasaem_aliman/features/sebha/presentation/cubit/sebha_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! ---------------- Quran ----------------

  // Cubit
  sl.registerFactory(() => QuranCubit(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SurahDetailsCubit(sl()));
  sl.registerFactory(() => AyahsCubit(sl()));
  sl.registerFactory(() => QuranPagesViewCubit(sl(), sl(), sl()));

  // UseCases
  sl.registerLazySingleton(() => GetAllSurahs(sl()));
  sl.registerLazySingleton(() => GetSurah(sl()));
  sl.registerLazySingleton(() => GetAllJuz(sl()));
  sl.registerLazySingleton(() => GetJuzAyahs(sl()));
  sl.registerLazySingleton(() => GroupAyahsByPage(sl()));
  sl.registerLazySingleton(() => GetQuranPages(sl()));
  sl.registerLazySingleton(() => GetPageForSurah(sl()));
  sl.registerLazySingleton(() => GetPageForJuzSurah(sl()));

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

  // Cubit
  sl.registerFactory(
    () => SebaaCubit(
      getAllSavedAzkar: sl(),
      saveZikr: sl(),
      updateZikr: sl(),
      deleteZikr: sl(),
      getCurrentZikr: sl(),
      setCurrentZikr: sl(),
      hasDefaultAzkarBeenAdded: sl(),
      markDefaultAzkarAsAdded: sl(),
    ),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllSavedAzkar(sl()));
  sl.registerLazySingleton(() => SaveZikr(sl()));
  sl.registerLazySingleton(() => UpdateZikr(sl()));
  sl.registerLazySingleton(() => DeleteZikr(sl()));
  sl.registerLazySingleton(() => GetCurrentZikr(sl()));
  sl.registerLazySingleton(() => SetCurrentZikr(sl()));
  sl.registerLazySingleton(() => HasDefaultAzkarBeenAdded(sl()));
  sl.registerLazySingleton(() => MarkDefaultAzkarAsAdded(sl()));

  // Repository
  sl.registerLazySingleton<SebhaRepository>(() => SebhaRepositoryImpl(sl()));

  // Datasource
  sl.registerLazySingleton<SebhaLocalDataSource>(
    () => SebhaLocalDataSourceImpl(),
  );
}
