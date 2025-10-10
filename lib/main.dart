import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/di.dart' as di;
import 'core/theme/app_theme.dart';
import 'features/nasaem_aliman_tabs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait mode only (no rotation allowed)
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Setup DI
  await di.init();

  runApp(const NasaemAlimanApp());
}

class NasaemAlimanApp extends StatelessWidget {
  const NasaemAlimanApp({super.key});

  // Design size optimized for mobile phones only
  Size get _designSize => const Size(360, 690);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
