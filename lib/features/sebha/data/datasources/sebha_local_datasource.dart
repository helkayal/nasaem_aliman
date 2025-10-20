import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sebha_zikr_model.dart';

abstract class SebhaLocalDataSource {
  Future<List<SebhaZikrModel>> getAllSavedAzkar();
  Future<void> saveZikr(SebhaZikrModel zikr);
  Future<void> updateZikr(SebhaZikrModel zikr);
  Future<void> deleteZikr(String id);
  Future<SebhaZikrModel?> getCurrentZikr();
  Future<void> setCurrentZikr(String? zikrId);
  Future<bool> hasDefaultAzkarBeenAdded();
  Future<void> markDefaultAzkarAsAdded();
}

class SebhaLocalDataSourceImpl implements SebhaLocalDataSource {
  static const _azkarListKey = 'sebha_saved_azkar';
  static const _currentZikrIdKey = 'sebha_current_zikr_id';
  static const _defaultAzkarAddedKey = 'sebha_default_azkar_added';

  @override
  Future<List<SebhaZikrModel>> getAllSavedAzkar() async {
    final prefs = await SharedPreferences.getInstance();
    final azkarListJson = prefs.getString(_azkarListKey);

    if (azkarListJson == null) return [];

    final List<dynamic> azkarList = json.decode(azkarListJson);
    return azkarList
        .map((json) => SebhaZikrModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveZikr(SebhaZikrModel zikr) async {
    final azkarList = await getAllSavedAzkar();
    azkarList.add(zikr);
    await _saveAzkarList(azkarList);
  }

  @override
  Future<void> updateZikr(SebhaZikrModel zikr) async {
    final azkarList = await getAllSavedAzkar();
    final index = azkarList.indexWhere((z) => z.id == zikr.id);

    if (index != -1) {
      azkarList[index] = zikr;
      await _saveAzkarList(azkarList);
    }
  }

  @override
  Future<void> deleteZikr(String id) async {
    final azkarList = await getAllSavedAzkar();
    azkarList.removeWhere((z) => z.id == id);
    await _saveAzkarList(azkarList);

    // If the deleted zikr was the current one, clear current zikr
    final currentZikrId = await _getCurrentZikrId();
    if (currentZikrId == id) {
      await setCurrentZikr(null);
    }
  }

  @override
  Future<SebhaZikrModel?> getCurrentZikr() async {
    final currentZikrId = await _getCurrentZikrId();
    if (currentZikrId == null) return null;

    final azkarList = await getAllSavedAzkar();
    try {
      return azkarList.firstWhere((z) => z.id == currentZikrId);
    } catch (e) {
      // Current zikr ID not found in list, clear it
      await setCurrentZikr(null);
      return null;
    }
  }

  @override
  Future<void> setCurrentZikr(String? zikrId) async {
    final prefs = await SharedPreferences.getInstance();
    if (zikrId == null) {
      await prefs.remove(_currentZikrIdKey);
    } else {
      await prefs.setString(_currentZikrIdKey, zikrId);
    }
  }

  Future<String?> _getCurrentZikrId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentZikrIdKey);
  }

  Future<void> _saveAzkarList(List<SebhaZikrModel> azkarList) async {
    final prefs = await SharedPreferences.getInstance();
    final azkarListJson = json.encode(
      azkarList.map((z) => z.toJson()).toList(),
    );
    await prefs.setString(_azkarListKey, azkarListJson);
  }

  @override
  Future<bool> hasDefaultAzkarBeenAdded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_defaultAzkarAddedKey) ?? false;
  }

  @override
  Future<void> markDefaultAzkarAsAdded() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_defaultAzkarAddedKey, true);
  }
}
