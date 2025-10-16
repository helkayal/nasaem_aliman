import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_converter.dart';
import '../../domain/entities/quran_page.dart';

class QuranPageWidget extends StatelessWidget {
  final QuranPageEntity page;

  const QuranPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    if (page.isEmpty) {
      return Center(
        child: Text(
          "صفحة فارغة",
          style: TextStyle(fontSize: 18.sp, color: AppColors.darkGrey),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppConstants.defaultPadding.w),
      child: Column(
        children: [
          // Page header with page number and surah info
          _buildPageHeader(),
          SizedBox(height: 16.h),

          // Ayahs content
          Expanded(child: SingleChildScrollView(child: _buildAyahsContent())),
        ],
      ),
    );
  }

  Widget _buildPageHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "صفحة ${NumberConverter.toArabicNumbers(page.pageNumber.toString())}",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
          if (page.surahIds.isNotEmpty)
            Text(
              _getSurahNames(),
              style: TextStyle(fontSize: 12.sp, color: AppColors.darkGrey),
            ),
        ],
      ),
    );
  }

  Widget _buildAyahsContent() {
    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: TextStyle(
          fontSize: 20.sp,
          height: 2.0,
          color: AppColors.black,
          fontFamily: 'NotoSansArabic', // Use Arabic font if available
        ),
        children: _buildAyahSpans(),
      ),
    );
  }

  List<TextSpan> _buildAyahSpans() {
    final spans = <TextSpan>[];

    for (int i = 0; i < page.ayahs.length; i++) {
      final ayah = page.ayahs[i];

      // Add ayah text
      spans.add(
        TextSpan(
          text: ayah.text,
          style: TextStyle(fontSize: 20.sp, color: AppColors.black),
        ),
      );

      // Add ayah number marker
      spans.add(
        TextSpan(
          text: " ${NumberConverter.toArabicNumbers(ayah.number.toString())} ",
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.blue,
            fontWeight: FontWeight.bold,
            backgroundColor: AppColors.lightBlue.withValues(alpha: 0.2),
          ),
        ),
      );

      // Add space between ayahs
      if (i < page.ayahs.length - 1) {
        spans.add(
          TextSpan(
            text: " ",
            style: TextStyle(fontSize: 20.sp),
          ),
        );
      }
    }

    return spans;
  }

  String _getSurahNames() {
    if (page.surahIds.isEmpty) return "";
    if (page.surahIds.length == 1) {
      return "سورة ${page.surahIds.first}";
    }
    return "سور متعددة";
  }
}
