class NumberConverter {
  // Map of English digits to Arabic-Indic digits
  static const Map<String, String> _englishToArabic = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  /// Converts English numbers to Arabic-Indic numbers
  /// Example: "123" -> "١٢٣"
  static String toArabicNumbers(String text) {
    String result = text;
    _englishToArabic.forEach((english, arabic) {
      result = result.replaceAll(english, arabic);
    });
    return result;
  }

  /// Converts integer to Arabic-Indic numbers
  /// Example: 123 -> "١٢٣"
  static String intToArabic(int number) {
    return toArabicNumbers(number.toString());
  }

  /// Converts double to Arabic-Indic numbers
  /// Example: 12.5 -> "١٢.٥"
  static String doubleToArabic(double number) {
    return toArabicNumbers(number.toString());
  }

  /// Converts Arabic-Indic numbers back to English (if needed)
  /// Example: "١٢٣" -> "123"
  static String toEnglishNumbers(String text) {
    String result = text;
    _englishToArabic.forEach((english, arabic) {
      result = result.replaceAll(arabic, english);
    });
    return result;
  }
}
