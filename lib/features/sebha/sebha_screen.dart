import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:nasaem_aliman/core/constants/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../core/widgets/custom_app_bar.dart';
import '../../core/utils/responsive_utils.dart';

class SebhaScreen extends StatefulWidget {
  const SebhaScreen({super.key});

  @override
  State<SebhaScreen> createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen>
    with AutomaticKeepAliveClientMixin<SebhaScreen>, WidgetsBindingObserver {
  int counter = 0;
  String? zekr; // null means no zekr yet
  final int totalBeads = 33;

  Timer? _saveTimer;
  bool _pendingSave = false;

  // 🔹 Sebha head - will be calculated in build method
  ui.Image? beadUiImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadBeadImage();
    _loadData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      if (_pendingSave) _saveData();
    }
  }

  Future<void> _loadBeadImage() async {
    try {
      final data = await rootBundle.load(AppAssets.sebhaBeadImage);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();
      if (!mounted) return;
      setState(() {
        beadUiImage = frame.image;
      });
    } catch (_) {
      // swallow – UI just won't show beads if loading fails
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      zekr = prefs.getString('zekr');
      counter = prefs.getInt('counter') ?? 0;
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

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
    super.build(context); // for AutomaticKeepAliveClientMixin
    final screenWidth = MediaQuery.of(context).size.width;

    final highlightedIndex = counter % totalBeads;

    // 🔹 Responsive sizing - calculate in build method
    final isTablet = ResponsiveUtils.isTablet(context);
    final sebhaHeadHeight = isTablet
        ? ResponsiveUtils.responsiveHeight(90) // Larger on tablets
        : ResponsiveUtils.responsiveHeight(60); // Keep original on phones
    final sebhaHeadTop = ResponsiveUtils.responsiveHeight(20);

    // 🔹 Oval size - responsive sizing
    final ovalWidth = isTablet
        ? screenWidth *
              0.75 // Reasonable size on tablets
        : screenWidth * 0.8; // Good size on phones
    final ovalHeight = isTablet
        ? screenWidth *
              0.8 // Circular on tablets
        : screenWidth * 0.9; // Circular on phones

    // 🔹 Center - closer to sebha head with better positioning
    final centerX = screenWidth / 2;
    final gapBetweenHeadAndOval = isTablet
        ? -40.0
        : -30.0; // Negative gap to bring closer
    final ovalCenterY =
        sebhaHeadTop +
        sebhaHeadHeight +
        gapBetweenHeadAndOval +
        (ovalHeight / 2);
    final centerY = ovalCenterY;

    return Scaffold(
      appBar: CustomAppBar(
        title: "السبحه",
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
                  left:
                      centerX -
                      (isTablet
                              ? screenWidth *
                                    0.2 // Smaller head on tablets
                              : screenWidth * 0.3) /
                          2,
                  top: sebhaHeadTop,
                  child: Opacity(
                    opacity: (zekr != null && zekr!.isNotEmpty) ? 1.0 : 0.4,
                    child: Container(
                      width: isTablet
                          ? screenWidth *
                                0.2 // Larger on tablets
                          : screenWidth * 0.3,
                      height: sebhaHeadHeight,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/sebha_head.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
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
                        beadSize: isTablet
                            ? screenWidth *
                                  0.063 // Proportional beads on tablets
                            : screenWidth * 0.08, // Better proportion on phones
                        centerX: centerX,
                        centerY: centerY,
                        enabled: zekr != null && zekr!.isNotEmpty,
                        primaryColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),

                // 🔹 Center text + counter - positioned in oval center
                Positioned(
                  left: 0,
                  right: 0,
                  top: centerY - 25, // Perfectly centered in the oval
                  child: buildZekrTextWithCount(zekr, counter, screenWidth),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildZekrTextWithCount(String? zekr, int counter, double screenWidth) {
    final isTablet = ResponsiveUtils.isTablet(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
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
                constraints: BoxConstraints(
                  maxWidth: isTablet
                      ? screenWidth *
                            0.5 // Narrower on tablets
                      : screenWidth * 0.65,
                ),
                child: Text(
                  zekr,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.responsiveFontSize(18),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 3,
                ),
              ),
            ),
          ),
          SizedBox(height: ResponsiveUtils.responsiveHeight(10)),
          Text(
            '$counter',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveUtils.responsiveFontSize(20),
            ),
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
  late final List<Offset> _centers = _computeCenters();

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

  List<Offset> _computeCenters() {
    final radiusX = (ovalWidth / 2) - beadSize; // Better spacing
    final radiusY = (ovalHeight / 2) - beadSize; // Better spacing
    return List.generate(totalBeads, (i) {
      final angle = 2 * pi * i / totalBeads - pi / 2;
      final x = centerX + radiusX * cos(angle);
      final y = centerY + radiusY * sin(angle);
      return Offset(x, y);
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (int i = 0; i < totalBeads; i++) {
      final center = _centers[i];

      final rect = Rect.fromCenter(
        center: center,
        width: beadSize,
        height: beadSize,
      );

      if (enabled && i == highlightedIndex) {
        final glowPaint = Paint()
          ..color = primaryColor.withValues(alpha: 0.5)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
        canvas.drawCircle(center, beadSize * 0.55, glowPaint);
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
        oldDelegate.enabled != enabled ||
        oldDelegate.ovalWidth != ovalWidth ||
        oldDelegate.ovalHeight != ovalHeight ||
        oldDelegate.centerX != centerX ||
        oldDelegate.centerY != centerY ||
        oldDelegate.beadSize != beadSize ||
        oldDelegate.totalBeads != totalBeads ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.beadUiImage != beadUiImage; // image swap
  }
}
