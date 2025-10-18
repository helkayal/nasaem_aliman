import 'package:flutter/material.dart';

class IconConverter {
  static final Map<String, IconData> _iconMap = {
    'Icons.sunny': Icons.sunny,
    'Icons.dark_mode_rounded': Icons.dark_mode_rounded,
    'Icons.hail_rounded': Icons.hail_rounded,
    'Icons.mosque': Icons.mosque,
    'Icons.star': Icons.star,
  };

  /// Converts a string representation of an icon to IconData
  /// Returns Icons.star as default if the icon is not found
  static IconData fromString(String iconString) {
    return _iconMap[iconString] ?? Icons.star;
  }

  /// Gets all available icon names
  static List<String> get availableIcons => _iconMap.keys.toList();

  /// Checks if an icon string is valid
  static bool isValidIcon(String iconString) {
    return _iconMap.containsKey(iconString);
  }
}
