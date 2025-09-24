import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/app_divider.dart';
import '../../domain/entities/azkar_category_entiti.dart';

class RepeatableAzkarList extends StatefulWidget {
  const RepeatableAzkarList({super.key, required this.category});

  final AzkarCategoryEntity category;

  @override
  State<RepeatableAzkarList> createState() => _RepeatableAzkarListState();
}

class _RepeatableAzkarListState extends State<RepeatableAzkarList> {
  late PageController _pageController;
  late List<int> _counters;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _counters = List.generate(widget.category.azkar.length, (_) => 0);
  }

  void _handleTap(int index, bool isDoubleTap) {
    final zekr = widget.category.azkar[index];
    final current = _counters[index];

    // Already completed → do nothing
    if (current >= zekr.count) return;

    // ✅ Special case: if zekr.count == 1 → just complete and move on
    if (zekr.count == 1) {
      setState(() {
        _counters[index] = 1;
      });
      HapticFeedback.mediumImpact();
      _goToNext(index);
      return;
    }

    // Normal case (zekr.count > 1)
    int increment = isDoubleTap ? 2 : 1;
    int newValue = current + increment;

    if (newValue >= zekr.count) {
      // clamp to zekr.count
      setState(() {
        _counters[index] = zekr.count;
      });
      HapticFeedback.mediumImpact();
      _goToNext(index);
    } else {
      setState(() {
        _counters[index] = newValue;
      });
    }
  }

  void _goToNext(int currentIndex) {
    if (currentIndex < widget.category.azkar.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemCount: widget.category.azkar.length,
      itemBuilder: (context, index) {
        final zekr = widget.category.azkar[index];
        final counter = _counters[index];

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _handleTap(index, false),
          onDoubleTap: () => _handleTap(index, true),
          child: Column(
            children: [
              // Scrollable zekr content
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    spacing: 20.h,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(height: 1.6.h),
                          children: _buildZekrText(zekr.text),
                        ),
                      ),
                      if (zekr.count > 1) const AppDivider(),
                      if (zekr.count > 1)
                        Text(
                          'التكرار: ${zekr.count}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                    ],
                  ),
                ),
              ),

              // Fixed bottom bar (only if zekr.count > 1)
              if (zekr.count > 1) _buildBottomButtons(context, counter, index),
            ],
          ),
        );
      },
    );
  }

  Container _buildBottomButtons(BuildContext context, int counter, int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -1),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          _buildCounterContainer(context, counter),
          counter > 0 ? _buildResetButton(index, context) : SizedBox.shrink(),
        ],
      ),
    );
  }

  GestureDetector _buildResetButton(int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _counters[index] = 0;
        });
      },
      child: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.refresh,
          size: 16.h,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Container _buildCounterContainer(BuildContext context, int counter) {
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text('$counter', style: Theme.of(context).textTheme.headlineSmall),
    );
  }

  List<InlineSpan> _buildZekrText(String text) {
    const start1 = "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ";
    const start2 = "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم";

    if (text.startsWith(start1)) {
      return [
        TextSpan(
          text: "$start1\n\n",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: text.substring(start1.length).trim()),
      ];
    } else if (text.startsWith(start2)) {
      return [
        TextSpan(
          text: "$start2\n\n",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: text.substring(start2.length).trim()),
      ];
    } else {
      return [TextSpan(text: text)];
    }
  }
}
