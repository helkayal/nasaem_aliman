import 'package:flutter/material.dart';

import '../widgets/juza_tab.dart';
import '../widgets/surah_tab.dart';

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
