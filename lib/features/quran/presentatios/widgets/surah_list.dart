import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_divider.dart';
import '../../../../core/widgets/app_number_bg.dart';
import '../../domain/entities/surah.dart';
import '../cubit/quran_pages_view_cubit.dart';
import 'quran_page_view.dart';

class SurahsList extends StatelessWidget {
  final List<SurahEntity> surahsList;
  const SurahsList({super.key, required this.surahsList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, i) {
        final SurahEntity surah = surahsList[i];
        return buildSurahsList(context, surah);
      },
      separatorBuilder: (context, index) {
        return AppDivider();
      },
      itemCount: surahsList.length,
    );
  }

  InkWell buildSurahsList(BuildContext context, SurahEntity surah) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => sl<QuranPagesViewCubit>(),
              child: QuranPageViewScreen(
                initialPage: surah.pages.isNotEmpty ? surah.pages.first : 1,
                title: "سوره ${surah.name}",
              ),
            ),
          ),
        );
      },
      child: buildSurahRow(context, surah),
    );
  }

  Padding buildSurahRow(BuildContext context, SurahEntity surah) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding * 2.w,
        vertical: AppConstants.defaultPadding * 1.5.h,
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        spacing: 20,
        children: [
          AppNumberBg(
            fontScale: 'medium',
            isDark: Theme.of(context).brightness == Brightness.dark,
            rowNumber: NumberConverter.intToArabic(surah.id),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'سوره ${surah.name}',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.right,
              ),
              SizedBox(height: AppConstants.defaultPadding * 0.5.h),
              Text(
                surah.revelationType,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'صفحة ${NumberConverter.intToArabic(surah.pages.isNotEmpty ? surah.pages.first : 1)}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: AppConstants.defaultPadding * 0.5.h),
                Text(
                  'الجزء ${NumberConverter.intToArabic(((surah.pages.isNotEmpty ? surah.pages.first : 1) / 20).ceil())}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
