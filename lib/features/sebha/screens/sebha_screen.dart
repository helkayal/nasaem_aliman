import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/core/constants/app_assets.dart';
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

  Timer? _saveTimer;
  bool _pendingSave = false;

  // 🔹 Sebha head
  final sebhaHeadHeight = 60.h;
  final sebhaHeadTop = 20.h;

  late final Image headImage;
  ui.Image? beadUiImage;

  @override
  void initState() {
    super.initState();
    headImage = Image.asset(
      AppAssets.sebhaHeadImage,
      height: sebhaHeadHeight,
      fit: BoxFit.fitHeight,
    );
    _loadBeadImage();
    _loadData();
  }

  Future<void> _loadBeadImage() async {
    final data = await DefaultAssetBundle.of(
      context,
    ).load(AppAssets.sebhaBeadImage);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    setState(() {
      beadUiImage = frame.image;
    });
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
    if (zekr == null || zekr!.isEmpty) return;
    setState(() => counter++);
    _pendingSave = true;
    _debounceSave();
  }

  void _debounceSave() {
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), () {
      if (_pendingSave) {
        _saveData();
        _pendingSave = false;
      }
    });
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    if (_pendingSave) _saveData();
    super.dispose();
  }

  void _resetCounter() {
    setState(() => counter = 0);
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
        counter = 0;
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

    // 🔹 Center
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
        absorbing: zekr == null || zekr!.isEmpty,
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
                    opacity: (zekr != null && zekr!.isNotEmpty) ? 1.0 : 0.4,
                    child: headImage,
                  ),
                ),

                // 🔹 CustomPaint beads
                if (beadUiImage != null)
                  RepaintBoundary(
                    child: CustomPaint(
                      painter: BeadsPainter(
                        beadUiImage: beadUiImage!,
                        totalBeads: totalBeads,
                        highlightedIndex: highlightedIndex,
                        ovalWidth: ovalWidth,
                        ovalHeight: ovalHeight,
                        beadSize: screenWidth * 0.1,
                        centerX: centerX,
                        centerY: centerY,
                        enabled: zekr != null && zekr!.isNotEmpty,
                        primaryColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const SizedBox.expand(),
                    ),
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
            onLongPress: () => _editZekrInline(),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 800),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
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
}

/// 🔹 CustomPainter for beads
class BeadsPainter extends CustomPainter {
  final ui.Image beadUiImage;
  final int totalBeads;
  final int highlightedIndex;
  final double ovalWidth;
  final double ovalHeight;
  final double beadSize;
  final double centerX;
  final double centerY;
  final bool enabled;
  final Color primaryColor;

  BeadsPainter({
    required this.beadUiImage,
    required this.totalBeads,
    required this.highlightedIndex,
    required this.ovalWidth,
    required this.ovalHeight,
    required this.beadSize,
    required this.centerX,
    required this.centerY,
    required this.enabled,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final radiusX = ovalWidth / 2;
    final radiusY = ovalHeight / 2;

    for (int i = 0; i < totalBeads; i++) {
      final angle = 2 * pi * i / totalBeads - pi / 2;
      final x = centerX + radiusX * cos(angle);
      final y = centerY + radiusY * sin(angle) + 10;

      final rect = Rect.fromCenter(
        center: Offset(x, y),
        width: beadSize,
        height: beadSize,
      );

      if (enabled && i == highlightedIndex) {
        final glowPaint = Paint()
          ..color = primaryColor.withValues(alpha: 0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
        canvas.drawCircle(Offset(x, y), beadSize * 0.55, glowPaint);
      }

      paint.color = enabled
          ? Colors.white
          : Colors.white.withValues(alpha: 0.4);

      canvas.drawImageRect(
        beadUiImage,
        Rect.fromLTWH(
          0,
          0,
          beadUiImage.width.toDouble(),
          beadUiImage.height.toDouble(),
        ),
        rect,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BeadsPainter oldDelegate) {
    return oldDelegate.highlightedIndex != highlightedIndex ||
        oldDelegate.enabled != enabled;
  }
}
