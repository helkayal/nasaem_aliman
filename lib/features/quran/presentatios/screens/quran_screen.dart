import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/di.dart' as di;
import '../cubit/quran_pages_view_cubit.dart';
import '../widgets/juza_tab.dart';
import '../widgets/surah_tab.dart';
import 'quran_page_view_screen.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("القران الكريم"),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          bottom: TabBar(
            tabs: [
              Tab(text: "السور"),
              Tab(text: "الاجزاء"),
              Tab(text: "المصحف"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SurahTab(),
            JuzaTab(),
            BlocProvider(
              create: (_) => di.sl<QuranPagesViewCubit>(),
              child: QuranPageViewScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
