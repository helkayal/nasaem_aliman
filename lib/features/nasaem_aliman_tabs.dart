import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/constants/app_constants.dart';
import 'package:nasaem_aliman/core/di/di.dart' as di;
import 'package:nasaem_aliman/core/theme/app_colors.dart';
import 'package:nasaem_aliman/features/azkar/presentatios/cubit/azkar_category_cubit.dart';
import 'package:nasaem_aliman/features/azkar/presentatios/screens/azkar_screen.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/quran_screen.dart';
import 'package:nasaem_aliman/features/sebha/sebha_screen.dart';

class NasaemAlimanTabs extends StatefulWidget {
  const NasaemAlimanTabs({super.key});

  @override
  State<NasaemAlimanTabs> createState() => _NasaemAlimanTabsState();
}

class _NasaemAlimanTabsState extends State<NasaemAlimanTabs> {
  int _currentIndex = 1;

  final List<Widget> _screens = [
    const SebhaScreen(),
    BlocProvider(
      create: (_) => di.sl<QuranCubit>()..fetchAllSurahs(),
      child: const QuranScreen(),
    ),
    BlocProvider(
      create: (_) => di.sl<AzkarCategoriesCubit>()..loadAzkarCategories(),
      child: const AzkarScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.darkBlue,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.darkBlue.withValues(alpha: 0.25),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.defaultRadius.r * 2),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() => _currentIndex = index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.solidTasbih2),
                label: "السبحه",
              ),
              BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.solidQuran2),
                label: "القران",
              ),
              BottomNavigationBarItem(
                icon: Icon(FlutterIslamicIcons.solidTasbihHand),
                label: "الأذكار",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
