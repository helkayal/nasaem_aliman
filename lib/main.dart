import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/di.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/nasaem_aliman_tabs.dart';

Future<void> main() async {
  // Setup DI
  await di.init();

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
          title: 'Nasaem Aliman',
          themeMode: ThemeMode.system,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          home: child,
        );
      },
      child: const NasaemAlimanTabs(),
    );
  }
}
