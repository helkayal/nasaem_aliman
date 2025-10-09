import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/entities/ayah.dart';
import '../cubit/ayahs_cubit.dart';
import '../cubit/ayahs_state.dart';

class SurahText extends StatefulWidget {
  const SurahText({
    super.key,
    required this.filteredAyahs,
    required this.surahNumber,
    required this.surahName,
  });

  final List<AyahEntity> filteredAyahs;
  final int surahNumber;
  final String surahName;

  @override
  State<SurahText> createState() => _SurahTextState();
}

class _SurahTextState extends State<SurahText> {
  @override
  void initState() {
    super.initState();
    // Trigger fetching once widget is mounted
    context.read<AyahsCubit>().fetchAyahsByPage(
      widget.filteredAyahs,
      widget.surahNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AyahsCubit, AyahsStates>(
      builder: (context, state) {
        if (state is AyahStateLoading) {
          return const AppLoading();
        } else if (state is AyahStateError) {
          return AppError(message: state.message);
        } else if (state is AyahStateLoaded) {
          final isDark = Theme.of(context).brightness == Brightness.dark;

          final pagesMap = state.ayahs;
          final pageNumbers = pagesMap.keys.toList()..sort();

          return PageView.builder(
            scrollDirection: Axis.horizontal,
            reverse: true,
            itemCount: pageNumbers.length,
            itemBuilder: (context, index) {
              final ayahs = pagesMap[pageNumbers[index]]!;
              final showBasmalah =
                  widget.surahNumber != 1 &&
                  widget.surahNumber != 9 &&
                  ayahs.first.number == 1;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: RichText(
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.titleSmall,
                      children: [
                        if (showBasmalah)
                          WidgetSpan(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 16,
                                  top: 16,
                                ),
                                child: Text(
                                  // '﷽',
                                  'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                        ...ayahs.expand((ayah) {
                          return [
                            TextSpan(
                              text: ayah.text,
                              style: const TextStyle(height: 2),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6.w),
                                width: 42.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      isDark
                                          ? AppAssets.numberBgDark
                                          : AppAssets.numberBg,
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${ayah.number}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            ),
                          ];
                        }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        // Initial state
        return const SizedBox.shrink();
      },
    );
  }
}
