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

  Size _getDesignSize(BuildContext context) {
    final data = MediaQuery.of(context);
    final isTablet = data.size.shortestSide >= 600;

    if (isTablet) {
      // Use larger design size for tablets to prevent over-scaling
      return const Size(768, 1024);
    } else {
      // Keep original design size for phones
      return const Size(360, 690);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _getDesignSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Nasaem Aliman',
          themeMode: ThemeMode.system,
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          home: child,
        );
      },
      child: const NasaemAlimanTabs(),
    );
  }
}
