import 'package:flutter/material.dart';
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

  void _handleTap(int index) {
    final zekr = widget.category.azkar[index];

    // If zekr is already completed, do nothing
    if (_counters[index] >= zekr.count) {
      return;
    }

    if (zekr.count == 1) {
      _goToNext(index);
    } else {
      setState(() {
        _counters[index]++;
      });

      if (_counters[index] >= zekr.count) {
        _goToNext(index);
      }
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

  // @override
  // Widget build(BuildContext context) {
  //   return PageView.builder(
  //     controller: _pageController,
  //     scrollDirection: Axis.horizontal,
  //     reverse: true,
  //     itemCount: widget.category.azkar.length,
  //     itemBuilder: (context, index) {
  //       final zekr = widget.category.azkar[index];
  //       final counter = _counters[index];

  //       return GestureDetector(
  //         behavior: HitTestBehavior.opaque,
  //         onTap: () => _handleTap(index),
  //         child: SizedBox.expand(
  //           child: Stack(
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.symmetric(
  //                   horizontal: 16.w,
  //                   vertical: 20.h,
  //                 ),
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     spacing: 20.h,
  //                     children: [
  //                       RichText(
  //                         textAlign: TextAlign.center,
  //                         text: TextSpan(
  //                           style: Theme.of(
  //                             context,
  //                           ).textTheme.titleLarge!.copyWith(height: 2.5),
  //                           children: _buildZekrText(zekr.text),
  //                         ),
  //                       ),
  //                       if (zekr.count > 1) const AppDivider(),
  //                       if (zekr.count > 1)
  //                         Text(
  //                           'التكرار: ${zekr.count}',
  //                           style: Theme.of(context).textTheme.bodyMedium,
  //                         ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               if (zekr.count > 1) _buildButtons(context, counter, index),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

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
          onTap: () => _handleTap(index),
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
                          ).textTheme.titleLarge!.copyWith(height: 2.5),
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
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$counter',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          GestureDetector(
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
          ),
        ],
      ),
    );
  }

  List<InlineSpan> _buildZekrText(String text) {
    const start1 = "أَعُوذُ بِاللهِ مِنْ الشَّيْطَانِ الرَّجِيمِ";
    const start2 = "بِسْمِ اللهِ الرَّحْمنِ الرَّحِيم";

    if (text.startsWith(start1)) {
      return [
        TextSpan(
          text: "$start1\n",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: text.substring(start1.length).trim()),
      ];
    } else if (text.startsWith(start2)) {
      return [
        TextSpan(
          text: "$start2\n",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(text: text.substring(start2.length).trim()),
      ];
    } else {
      return [TextSpan(text: text)];
    }
  }
}
