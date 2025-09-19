import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/theme/app_theme.dart';
import 'package:nasaem_aliman/features/splash/splash_screen.dart';
import 'package:nasaem_aliman/simple_bloc_observer.dart';
import 'core/di/di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup DI
  await di.init();

  Bloc.observer = SimpleBlocObserver();

  runApp(const NasaemAlimanApp());
}

class NasaemAlimanApp extends StatelessWidget {
  const NasaemAlimanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nasa\'em Al-Iman',
          themeMode: ThemeMode.system,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
