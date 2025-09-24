//   final List<String> azkar = [
//     "سُبْحَانَ اللَّهِ",
//     "الْحَمْدُ لِلَّهِ",
//     "اللَّهُ أَكْبَرُ",
//     "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ",
//     "لَا إِلَهَ إِلَّا اللَّهُ",
//     "أَسْتَغْفِرُ اللَّهُ",
//     "سُبْحَانَ اللَّهِ وَبِحَمْدِهِ",
//     "سُبْحَانَ اللَّهِ الْعَظِيمِ",
//     "حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ",
//     "لَا إِلَهَ إِلَّا أَنْتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ",
//   ];

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int counter = 0;
  String? zekr; // null means no zekr yet
  final int totalBeads = 33;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      zekr = prefs.getString("zekr");
      counter = prefs.getInt("counter") ?? 0;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (zekr != null && zekr!.isNotEmpty) {
      await prefs.setString("zekr", zekr!);
      await prefs.setInt("counter", counter);
    }
  }

  void _incrementCounter() {
    if (zekr == null || zekr!.isEmpty) return; // block increment
    setState(() {
      counter++;
    });
    _saveData();
  }

  void _resetCounter() {
    setState(() {
      counter = 0;
    });
    _saveData();
  }

  Future<void> _editZekrInline({bool isNew = false}) async {
    final controller = TextEditingController(text: isNew ? "" : zekr ?? "");
    final newZekr = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          isNew ? "إضافة الذكر" : "تعديل الذكر",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "أدخل الذكر"),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("إلغاء", style: Theme.of(context).textTheme.bodySmall),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text("حفظ", style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );

    if (newZekr != null && newZekr.isNotEmpty) {
      setState(() {
        zekr = newZekr;
        counter = 0; // reset when new zekr entered
      });
      _saveData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final highlightedIndex = counter % totalBeads;

    // 🔹 Oval size
    final ovalWidth = screenWidth * 0.85;
    final ovalHeight = screenHeight * 0.45;

    // 🔹 Sebha head dimensions
    final sebhaHeadHeight = screenHeight * 0.09;
    final sebhaHeadTop = 20.h;

    // 🔹 Oval center (aligned so top bead matches head bottom)
    final centerX = screenWidth / 2;
    final centerY = sebhaHeadTop + sebhaHeadHeight + (ovalHeight / 2);

    return Scaffold(
      appBar: AppBar(
        title: const Text("السبحه"),
        actions: [
          if (zekr == null || zekr!.isEmpty) ...[
            IconButton(
              onPressed: () => _editZekrInline(isNew: true),
              icon: const Icon(Icons.add),
              tooltip: "إضافة الذكر",
            ),
          ] else ...[
            IconButton(
              onPressed: _resetCounter,
              icon: const Icon(Icons.refresh),
              tooltip: "إعادة التصفير",
            ),
            IconButton(
              onPressed: () => _editZekrInline(),
              icon: const Icon(Icons.edit),
              tooltip: "تعديل الذكر",
            ),
          ],
        ],
      ),
      body: AbsorbPointer(
        absorbing: zekr == null || zekr!.isEmpty, // disable taps if no zekr
        child: GestureDetector(
          onTap: _incrementCounter,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sebha_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 🔹 Sebha head
                Positioned(
                  left: centerX - (screenWidth * 0.3) / 2,
                  top: sebhaHeadTop,
                  child: Opacity(
                    opacity: (zekr != null && zekr!.isNotEmpty)
                        ? 1.0
                        : 0.4, // 🔹 dim sehba head if disabled
                    child: Image.asset(
                      "assets/images/sebha_head.png",
                      height: sebhaHeadHeight,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),

                // 🔹 Beads loop
                for (int i = 0; i < totalBeads; i++)
                  buildBead(
                    i,
                    highlightedIndex,
                    ovalWidth,
                    ovalHeight,
                    screenWidth,
                    centerX,
                    centerY,
                    enabled: zekr != null && zekr!.isNotEmpty,
                  ),

                // 🔹 Center text + counter
                buildZekrTextWithCount(zekr, counter, screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildZekrTextWithCount(String? zekr, int counter, double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (zekr != null && zekr.isNotEmpty) ...[
          GestureDetector(
            onLongPress: () => _editZekrInline(), // long press to edit
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: ConstrainedBox(
                key: ValueKey<String>(zekr),
                constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
                child: Text(
                  zekr,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$counter',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ] else
          Text(
            "أضف ذكراً للبدء",
            style: Theme.of(context).textTheme.titleLarge,
          ),
      ],
    );
  }

  Widget buildBead(
    int index,
    int highlightedIndex,
    double ovalWidth,
    double ovalHeight,
    double screenWidth,
    double centerX,
    double centerY, {
    required bool enabled,
  }) {
    double angle = 2 * pi * index / totalBeads - pi / 2;

    double radiusX = ovalWidth / 2;
    double radiusY = ovalHeight / 2;

    double x = radiusX * cos(angle);
    double y = radiusY * sin(angle);

    double size = screenWidth * 0.1;

    final isHighlighted = enabled && index == highlightedIndex;

    return Positioned(
      left: centerX + x - size / 2,
      top: centerY + y - size / 2 + 10,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            if (isHighlighted)
              BoxShadow(
                color: Theme.of(context).colorScheme.primary,
                blurRadius: 14,
                spreadRadius: 6,
              ),
          ],
        ),
        child: Opacity(
          opacity: enabled ? 1.0 : 0.4, // dim beads if disabled
          child: Image.asset("assets/images/sebha_bead.png"),
        ),
      ),
    );
  }
}
