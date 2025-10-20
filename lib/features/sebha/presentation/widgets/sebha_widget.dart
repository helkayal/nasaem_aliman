import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/core/constants/app_assets.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/utils/number_converter.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../cubit/sebha_cubit.dart';
import '../cubit/sebha_state.dart';

class SebhaWidget extends StatefulWidget {
  const SebhaWidget({super.key});

  @override
  State<SebhaWidget> createState() => _SebhaWidgetState();
}

class _SebhaWidgetState extends State<SebhaWidget> {
  final int totalBeads = 33;
  ui.Image? beadUiImage;

  @override
  void initState() {
    super.initState();
    _loadBeadImage();
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<SebaaCubit, SebhaState>(
      builder: (context, state) {
        final currentZikr = state is SebhaLoaded ? state.currentZikr : null;
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
                        beadSize: screenWidth * 0.08,
                        centerX: centerX,
                        centerY: centerY,
                        enabled: currentZikr != null,
                        glowColor: Theme.of(context).colorScheme.tertiary,
                      ),
                      child: const SizedBox.expand(),
                    ),
                  ),

                // 🔹 Center text + counter
                Positioned(
                  left: 0,
                  right: 0,
                  top: centerY - 25,
                  child: _buildZekrTextWithCount(
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
    );
  }

  Column _buildZekrTextWithCount(
    String? zekr,
    int counter,
    double screenWidth,
  ) {
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
