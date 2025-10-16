import 'package:equatable/equatable.dart';
import 'ayah.dart';

class QuranPageEntity extends Equatable {
  final int pageNumber;
  final List<AyahEntity> ayahs;
  final Set<int> surahIds; // Which surahs appear on this page

  const QuranPageEntity({
    required this.pageNumber,
    required this.ayahs,
    required this.surahIds,
  });

  @override
  List<Object?> get props => [pageNumber, ayahs, surahIds];

  // Helper methods
  bool containsSurah(int surahId) => surahIds.contains(surahId);

  int get ayahCount => ayahs.length;

  bool get isEmpty => ayahs.isEmpty;

  // Get the main surah (the one with most ayahs on this page)
  int? get primarySurahId {
    if (surahIds.isEmpty) return null;
    if (surahIds.length == 1) return surahIds.first;

    // Find surah with most ayahs on this page
    final surahAyahCounts = <int, int>{};
    for (final ayah in ayahs) {
      surahAyahCounts[ayah.surahId] = (surahAyahCounts[ayah.surahId] ?? 0) + 1;
    }

    return surahAyahCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  // Get the first surah on this page (for cases with multiple surahs)
  int? get firstSurahId {
    if (ayahs.isEmpty) return null;
    return ayahs.first.surahId;
  }

  // Get surah name for AppBar display (uses first surah as requested)
  String get displaySurahName {
    final surahId = firstSurahId;
    if (surahId == null) return "المصحف الشريف";
    return _getSurahName(surahId);
  }

  // Get juz name for AppBar display
  String get displayJuzName {
    return _getJuzName(_getJuzForPage(pageNumber));
  }

  String _getSurahName(int surahId) {
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

  String _getJuzName(int juzNumber) {
    const juzNames = {
      1: "الجزء الأول",
      2: "الجزء الثاني",
      3: "الجزء الثالث",
      4: "الجزء الرابع",
      5: "الجزء الخامس",
      6: "الجزء السادس",
      7: "الجزء السابع",
      8: "الجزء الثامن",
      9: "الجزء التاسع",
      10: "الجزء العاشر",
      11: "الجزء الحادي عشر",
      12: "الجزء الثاني عشر",
      13: "الجزء الثالث عشر",
      14: "الجزء الرابع عشر",
      15: "الجزء الخامس عشر",
      16: "الجزء السادس عشر",
      17: "الجزء السابع عشر",
      18: "الجزء الثامن عشر",
      19: "الجزء التاسع عشر",
      20: "الجزء العشرون",
      21: "الجزء الحادي والعشرون",
      22: "الجزء الثاني والعشرون",
      23: "الجزء الثالث والعشرون",
      24: "الجزء الرابع والعشرون",
      25: "الجزء الخامس والعشرون",
      26: "الجزء السادس والعشرون",
      27: "الجزء السابع والعشرون",
      28: "الجزء الثامن والعشرون",
      29: "الجزء التاسع والعشرون",
      30: "الجزء الثلاثون",
    };
    return juzNames[juzNumber] ?? "الجزء رقم $juzNumber";
  }

  int _getJuzForPage(int pageNumber) {
    // Approximate juz boundaries based on standard Mushaf pages (604 pages total)
    const juzPageBoundaries = {
      1: [1, 21], // Juz 1: Al-Fatiha to Al-Baqarah 141
      2: [22, 41], // Juz 2: Al-Baqarah 142 to Al-Baqarah 252
      3: [42, 61], // Juz 3: Al-Baqarah 253 to Al Imran 92
      4: [62, 81], // Juz 4: Al Imran 93 to An-Nisa 23
      5: [82, 101], // Juz 5: An-Nisa 24 to An-Nisa 147
      6: [102, 121], // Juz 6: An-Nisa 148 to Al-Ma'idah 81
      7: [122, 141], // Juz 7: Al-Ma'idah 82 to Al-An'am 110
      8: [142, 161], // Juz 8: Al-An'am 111 to Al-A'raf 87
      9: [162, 181], // Juz 9: Al-A'raf 88 to Al-Anfal 40
      10: [182, 201], // Juz 10: Al-Anfal 41 to At-Tawbah 92
      11: [202, 221], // Juz 11: At-Tawbah 93 to Hud 5
      12: [222, 241], // Juz 12: Hud 6 to Yusuf 52
      13: [242, 261], // Juz 13: Yusuf 53 to Ibrahim 52
      14: [262, 281], // Juz 14: Al-Hijr 1 to An-Nahl 128
      15: [282, 301], // Juz 15: Al-Isra 1 to Al-Kahf 74
      16: [302, 321], // Juz 16: Al-Kahf 75 to Taha 135
      17: [322, 341], // Juz 17: Al-Anbiya 1 to Al-Hajj 78
      18: [342, 361], // Juz 18: Al-Mu'minun 1 to Al-Furqan 20
      19: [362, 381], // Juz 19: Al-Furqan 21 to An-Naml 55
      20: [382, 401], // Juz 20: An-Naml 56 to Al-Ankabut 45
      21: [402, 421], // Juz 21: Al-Ankabut 46 to Saba 23
      22: [422, 441], // Juz 22: Saba 24 to Sad 88
      23: [442, 461], // Juz 23: Az-Zumar 1 to Fussilat 46
      24: [462, 481], // Juz 24: Fussilat 47 to Al-Jathiyah 37
      25: [482, 501], // Juz 25: Al-Ahqaf 1 to Adh-Dhariyat 30
      26: [502, 521], // Juz 26: Adh-Dhariyat 31 to Al-Hadid 29
      27: [522, 541], // Juz 27: Al-Mujadila 1 to At-Tahrim 12
      28: [542, 561], // Juz 28: Al-Mulk 1 to Al-Mursalat 50
      29: [562, 581], // Juz 29: An-Naba 1 to At-Takwir 29
      30: [582, 604], // Juz 30: Al-Infitar 1 to An-Nas 6
    };

    for (final entry in juzPageBoundaries.entries) {
      final juzNumber = entry.key;
      final range = entry.value;
      if (pageNumber >= range[0] && pageNumber <= range[1]) {
        return juzNumber;
      }
    }

    return 1; // Default to first juz if not found
  }
}
