import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/title_with_border.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_number_bg.dart';
import '../../domain/entities/quran_page.dart';
import '../../domain/entities/ayah.dart';

class QuranPageWidget extends StatelessWidget {
  final QuranPageEntity page;

  const QuranPageWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    if (page.isEmpty) {
      return Center(
        child: Text("صفحة فارغة", style: Theme.of(context).textTheme.bodyLarge),
      );
    }

    return Container(
      padding: EdgeInsets.all(AppConstants.defaultPadding.w),
      child: Column(
        children: [
          // Ayahs content
          Expanded(
            child: SingleChildScrollView(child: _buildAyahsContent(context)),
          ),
          SizedBox(height: 12.h),
          // Page header with page number and surah info
          _buildPageFooter(context),
        ],
      ),
    );
  }

  Widget _buildPageFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        "صفحة ${NumberConverter.toArabicNumbers(page.pageNumber.toString())}",
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAyahsContent(BuildContext context) {
    return Column(children: _buildPageContent(context));
  }

  List<Widget> _buildPageContent(BuildContext context) {
    final widgets = <Widget>[];

    // Group ayahs by surah
    final Map<int, List<AyahEntity>> surahGroups = {};
    for (final ayah in page.ayahs) {
      surahGroups.putIfAbsent(ayah.surahId, () => []).add(ayah);
    }

    // Build content for each surah group
    for (final entry in surahGroups.entries) {
      final surahId = entry.key;
      final ayahs = entry.value;

      // Check if this surah starts with ayah 1 AND it's not the first ayah on the page
      final hasAyahOne = ayahs.any((ayah) => ayah.number == 1);
      final isFirstAyahOnPage =
          page.ayahs.isNotEmpty &&
          page.ayahs.first.surahId == surahId &&
          page.ayahs.first.number == 1;

      // Only show surah header if ayah 1 exists but it's NOT the first ayah on the page
      if (hasAyahOne && !isFirstAyahOnPage) {
        // Add surah name header with background
        widgets.add(_buildSurahHeader(surahId, context));
      }

      // Show Basmallah whenever ayah 1 appears (regardless of surah header)
      // Exception: Surah At-Tawbah (9) and Surah Al-Fatiha (1) don't have Basmallah
      if (hasAyahOne && surahId != 9 && surahId != 1) {
        widgets.add(_buildBasmallah(context));
      }

      // Add all ayahs of this surah as continuous text
      widgets.add(_buildSurahAyahs(ayahs, context));
    }

    return widgets;
  }

  Widget _buildSurahAyahs(List<AyahEntity> ayahs, BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: Theme.of(context).textTheme.titleSmall,
        children: _buildContinuousAyahSpans(ayahs, context),
      ),
    );
  }

  List<InlineSpan> _buildContinuousAyahSpans(
    List<AyahEntity> ayahs,
    BuildContext context,
  ) {
    final spans = <InlineSpan>[];

    for (int i = 0; i < ayahs.length; i++) {
      final ayah = ayahs[i];

      // Add ayah text
      spans.add(
        TextSpan(
          text: ayah.text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );

      // Add ayah number marker using AppNumberBg
      spans.add(
        WidgetSpan(
          child: AppNumberBg(
            fontScale: "x-small",
            isDark: Theme.of(context).brightness == Brightness.dark,
            rowNumber: NumberConverter.toArabicNumbers(ayah.number.toString()),
          ),
          alignment: PlaceholderAlignment.middle,
        ),
      );
    }

    return spans;
  }

  Widget _buildSurahHeader(int surahId, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TitleWithBorder(title: _getSurahName(surahId)),
    );
  }

  // Widget _buildSurahHeader(int surahId, BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 8.h),
  //     padding: EdgeInsets.symmetric(vertical: 8.h),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [
  //           Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),
  //           Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
  //         ],
  //         begin: Alignment.centerLeft,
  //         end: Alignment.centerRight,
  //       ),
  //       borderRadius: BorderRadius.circular(20.r),
  //       border: Border.all(
  //         color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
  //         width: 1,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
  //           offset: Offset(0, 2.h),
  //           blurRadius: 4.r,
  //         ),
  //       ],
  //     ),
  //     child: Center(
  //       child: Text(
  //         _getSurahName(surahId),
  //         style: Theme.of(context).textTheme.titleMedium!.copyWith(
  //           shadows: [
  //             Shadow(
  //               color: Theme.of(
  //                 context,
  //               ).colorScheme.primary.withValues(alpha: 0.7),
  //               offset: Offset(1, 1),
  //               blurRadius: 2,
  //             ),
  //           ],
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBasmallah(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Center(
        child: Text(
          "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  String _getSurahName(int surahId) {
    // Map of surah names (you can expand this or load from a data source)
    const surahNames = {
      1: "سورة الفاتحة",
      2: "سورة البقرة",
      3: "سورة آل عمران",
      4: "سورة النساء",
      5: "سورة المائدة",
      6: "سورة الأنعام",
      7: "سورة الأعراف",
      8: "سورة الأنفال",
      9: "سورة التوبة",
      10: "سورة يونس",
      11: "سورة هود",
      12: "سورة يوسف",
      13: "سورة الرعد",
      14: "سورة إبراهيم",
      15: "سورة الحجر",
      16: "سورة النحل",
      17: "سورة الإسراء",
      18: "سورة الكهف",
      19: "سورة مريم",
      20: "سورة طه",
      21: "سورة الأنبياء",
      22: "سورة الحج",
      23: "سورة المؤمنون",
      24: "سورة النور",
      25: "سورة الفرقان",
      26: "سورة الشعراء",
      27: "سورة النمل",
      28: "سورة القصص",
      29: "سورة العنكبوت",
      30: "سورة الروم",
      31: "سورة لقمان",
      32: "سورة السجدة",
      33: "سورة الأحزاب",
      34: "سورة سبأ",
      35: "سورة فاطر",
      36: "سورة يس",
      37: "سورة الصافات",
      38: "سورة ص",
      39: "سورة الزمر",
      40: "سورة غافر",
      41: "سورة فصلت",
      42: "سورة الشورى",
      43: "سورة الزخرف",
      44: "سورة الدخان",
      45: "سورة الجاثية",
      46: "سورة الأحقاف",
      47: "سورة محمد",
      48: "سورة الفتح",
      49: "سورة الحجرات",
      50: "سورة ق",
      51: "سورة الذاريات",
      52: "سورة الطور",
      53: "سورة النجم",
      54: "سورة القمر",
      55: "سورة الرحمن",
      56: "سورة الواقعة",
      57: "سورة الحديد",
      58: "سورة المجادلة",
      59: "سورة الحشر",
      60: "سورة الممتحنة",
      61: "سورة الصف",
      62: "سورة الجمعة",
      63: "سورة المنافقون",
      64: "سورة التغابن",
      65: "سورة الطلاق",
      66: "سورة التحريم",
      67: "سورة الملك",
      68: "سورة القلم",
      69: "سورة الحاقة",
      70: "سورة المعارج",
      71: "سورة نوح",
      72: "سورة الجن",
      73: "سورة المزمل",
      74: "سورة المدثر",
      75: "سورة القيامة",
      76: "سورة الإنسان",
      77: "سورة المرسلات",
      78: "سورة النبأ",
      79: "سورة النازعات",
      80: "سورة عبس",
      81: "سورة التكوير",
      82: "سورة الانفطار",
      83: "سورة المطففين",
      84: "سورة الانشقاق",
      85: "سورة البروج",
      86: "سورة الطارق",
      87: "سورة الأعلى",
      88: "سورة الغاشية",
      89: "سورة الفجر",
      90: "سورة البلد",
      91: "سورة الشمس",
      92: "سورة الليل",
      93: "سورة الضحى",
      94: "سورة الشرح",
      95: "سورة التين",
      96: "سورة العلق",
      97: "سورة القدر",
      98: "سورة البينة",
      99: "سورة الزلزلة",
      100: "سورة العاديات",
      101: "سورة القارعة",
      102: "سورة التكاثر",
      103: "سورة العصر",
      104: "سورة الهمزة",
      105: "سورة الفيل",
      106: "سورة قريش",
      107: "سورة الماعون",
      108: "سورة الكوثر",
      109: "سورة الكافرون",
      110: "سورة النصر",
      111: "سورة المسد",
      112: "سورة الإخلاص",
      113: "سورة الفلق",
      114: "سورة الناس",
    };

    return surahNames[surahId] ?? "سورة رقم $surahId";
  }
}
