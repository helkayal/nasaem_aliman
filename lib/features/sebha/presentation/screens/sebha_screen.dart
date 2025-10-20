import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/core/constants/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/di/di.dart' as di;
import '../cubit/sebha_cubit.dart';
import '../cubit/sebha_state.dart';
import '../widgets/saved_azkar_horizontal_list.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SebaaCubit>()..loadSavedAzkar(),
      child: const _SebhaScreenContent(),
    );
  }
}

class _SebhaScreenContent extends StatefulWidget {
  const _SebhaScreenContent();

  @override
  State<_SebhaScreenContent> createState() => _SebhaScreenContentState();
}

class _SebhaScreenContentState extends State<_SebhaScreenContent>
    with
        AutomaticKeepAliveClientMixin<_SebhaScreenContent>,
        WidgetsBindingObserver {
  int counter = 0;
  String? zekr; // null means no zekr yet
  final int totalBeads = 33;

  Timer? _saveTimer;
  final bool _pendingSave = false;

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

  @override
  void dispose() {
    _saveTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _showAddZikrDialog() async {
    final textController = TextEditingController();

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'إضافة ذكر جديد',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'نص الذكر',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final text = textController.text.trim();

              if (text.isNotEmpty) {
                Navigator.of(context).pop(text);
              }
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      context.read<SebaaCubit>().addZikr(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: "السبحه",
        actions: [
          IconButton(
            onPressed: _showAddZikrDialog,
            icon: const Icon(Icons.add),
            tooltip: "إضافة ذكر",
          ),
          BlocBuilder<SebaaCubit, SebhaState>(
            builder: (context, state) {
              final hasCurrentZikr =
                  state is SebhaLoaded && state.currentZikr != null;

              return IconButton(
                onPressed: hasCurrentZikr
                    ? () => context.read<SebaaCubit>().resetCounter()
                    : null,
                icon: Icon(
                  Icons.refresh,
                  color: hasCurrentZikr
                      ? null
                      : Theme.of(context).colorScheme.outline,
                ),
                tooltip: "إعادة التصفير",
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Saved azkar horizontal list
          const SavedAzkarHorizontalList(),

          SizedBox(height: 4.h),

          // Sebha widget
          Expanded(
            child: BlocBuilder<SebaaCubit, SebhaState>(
              builder: (context, state) {
                final currentZikr = state is SebhaLoaded
                    ? state.currentZikr
                    : null;
                final counter = currentZikr?.currentCount ?? 0;
                final highlightedIndex = counter % totalBeads;

                // 🔹 Responsive sizing - calculate in build method
                final sebhaHeadHeight = ResponsiveUtils.responsiveHeight(60);
                final sebhaHeadTop = ResponsiveUtils.responsiveHeight(0);

                // 🔹 Oval size - responsive sizing
                final ovalWidth = screenWidth * 0.95;
                final ovalHeight = screenWidth;

                // 🔹 Center - closer to sebha head with better positioning
                final centerX = screenWidth / 2;
                final gapBetweenHeadAndOval = -25.0;
                final ovalCenterY =
                    sebhaHeadTop +
                    sebhaHeadHeight +
                    gapBetweenHeadAndOval +
                    (ovalHeight / 2);
                final centerY = ovalCenterY;

                return AbsorbPointer(
                  absorbing: currentZikr == null,
                  child: GestureDetector(
                    onTap: currentZikr != null
                        ? () => context.read<SebaaCubit>().incrementCounter()
                        : null,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // 🔹 Sebha head
                        Positioned(
                          left: centerX - (screenWidth * 0.3) / 2,
                          top: sebhaHeadTop,
                          child: Opacity(
                            opacity: currentZikr != null ? 1.0 : 0.4,
                            child: Container(
                              width: screenWidth * 0.3,
                              height: sebhaHeadHeight,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/sebha_head.png',
                                  ),
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
                                beadSize: screenWidth * 0.08,
                                centerX: centerX,
                                centerY: centerY,
                                enabled: currentZikr != null,
                                glowColor: Theme.of(
                                  context,
                                ).colorScheme.tertiary,
                              ),
                              child: const SizedBox.expand(),
                            ),
                          ),

                        // 🔹 Center text + counter
                        Positioned(
                          left: 0,
                          right: 0,
                          top: centerY - 25,
                          child: buildZekrTextWithCount(
                            currentZikr?.text,
                            counter,
                            screenWidth,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column buildZekrTextWithCount(String? zekr, int counter, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (zekr != null && zekr.isNotEmpty) ...[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: ConstrainedBox(
              key: ValueKey<String>(zekr),
              constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
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
          SizedBox(height: ResponsiveUtils.responsiveHeight(10)),
          Text(
            NumberConverter.intToArabic(counter),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveUtils.responsiveFontSize(20),
            ),
          ),
        ] else
          Text(
            "اختر ذكراً من القائمة أعلاه",
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
  final Color glowColor;
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
    required this.glowColor,
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

      // Draw the bead image first
      if (enabled) {
        paint.color = Colors.white;
      } else {
        paint.color = Colors.white.withValues(alpha: 0.4);
      }

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

      // Draw colored overlay on top for highlighted bead
      if (enabled && i == highlightedIndex) {
        final colorPaint = Paint()
          ..color = glowColor.withValues(alpha: 0.7)
          ..blendMode = BlendMode.multiply; // Blend with the image below
        canvas.drawCircle(center, beadSize / 2.2, colorPaint);

        // Add a colored border for extra visibility
        final borderPaint = Paint()
          ..color = glowColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;
        canvas.drawCircle(center, beadSize / 2.2, borderPaint);
      }
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
        oldDelegate.glowColor != glowColor ||
        oldDelegate.beadUiImage != beadUiImage; // image swap
  }
}
