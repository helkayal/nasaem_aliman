import 'package:get_it/get_it.dart';

// Quran
import 'package:nasaem_aliman/features/quran/data/datasources/quran_local_datasource.dart';
import 'package:nasaem_aliman/features/quran/data/repositories/quran_repository_impl.dart';
import 'package:nasaem_aliman/features/quran/domain/repositories/quran_repository.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_surahs.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_surah.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_all_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_juz.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_bookmarks.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/add_bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/remove_bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/usecases/get_last_read.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';

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
  sl.registerFactory(
    () => QuranCubit(
      sl(), // GetAllSurahs
      sl(), // GetSurah
      // sl(), // GetAllJuz
      sl(), // GetJuz
      sl(), // GetBookmarks
      sl(), // AddBookmark
      sl(), // RemoveBookmark
      sl(), // GetLastRead
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetAllSurahs(sl()));
  sl.registerLazySingleton(() => GetSurah(sl()));
  sl.registerLazySingleton(() => GetAllJuz(sl()));
  sl.registerLazySingleton(() => GetJuz(sl()));
  sl.registerLazySingleton(() => GetBookmarks(sl()));
  sl.registerLazySingleton(() => AddBookmark(sl()));
  sl.registerLazySingleton(() => RemoveBookmark(sl()));
  sl.registerLazySingleton(() => GetLastRead(sl()));

  // Repository
  sl.registerLazySingleton<QuranRepository>(() => QuranRepositoryImpl(sl()));

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
