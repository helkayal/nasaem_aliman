import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/app_number_bg.dart';
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
                              style: Theme.of(context).textTheme.titleSmall,
                              // style: const TextStyle(height: 2),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: AppNumberBg(
                                fontScale: "x-small",
                                isDark: isDark,
                                rowNumber: NumberConverter.intToArabic(
                                  ayah.number,
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
