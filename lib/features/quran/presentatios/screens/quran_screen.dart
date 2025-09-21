import 'package:flutter/material.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/bookmarks_screen.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/juza_tab.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/surah_tab.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("القران الكريم"),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          bottom: TabBar(
            tabs: [
              Tab(text: "السور"),
              Tab(text: "الاجزاء"),
            ],
          ),
        ),
        body: TabBarView(children: [SurahTab(), JuzaTab()]),
      ),
    );
  }
}
