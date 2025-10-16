import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../domain/entities/juz.dart';
import '../cubit/quran_pages_view_cubit.dart';
import 'quran_page_view.dart';
import 'list_row.dart';

class JuzasList extends StatefulWidget {
  final List<JuzEntity> juzList;
  const JuzasList({super.key, required this.juzList});

  @override
  State<JuzasList> createState() => _JuzasListState();
}

class _JuzasListState extends State<JuzasList> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(AppConstants.defaultPadding.h),
      itemCount: widget.juzList.length,
      itemBuilder: (context, index) {
        final juz = widget.juzList[index];
        final isExpanded = expandedIndex == index;

        return Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.defaultPadding.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_drop_down,
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 30,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ListRow(
                        text: juz.name,
                        rowNumber: NumberConverter.intToArabic(juz.id),
                        rowTrailer: "",
                        withTrailer: false,
                        withLeading: false,
                        fontScale: "medium",
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Expanded children
            if (isExpanded)
              Column(
                children: juz.surahRanges
                    .map((range) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding * 3.w,
                        ),
                        child: InkWell(
                          onTap: () async {
                            final cubit = sl<QuranPagesViewCubit>();
                            final pageNumber = await cubit.getPageForJuzSurah(
                              juz.id,
                              range.surahId,
                              range.startAyah,
                            );

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: cubit,
                                    child: QuranPageViewScreen(
                                      initialPage: pageNumber,
                                      title: juz.name,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: ListRow(
                              text: range.surahName,
                              rowNumber: NumberConverter.intToArabic(
                                range.surahId,
                              ),
                              rowTrailer:
                                  "( ${NumberConverter.intToArabic(range.startAyah)} - ${NumberConverter.intToArabic(range.endAyah)})",
                              // "من آية ${range.startAyah} إلى ${range.endAyah}",
                              fontScale: "medium",
                            ),
                          ),
                        ),
                      );
                    })
                    .toList()
                    .cast<Widget>(),
              ),

            if (index != widget.juzList.length - 1)
              const AppDivider(height: 16),
          ],
        );
      },
    );
  }
}
