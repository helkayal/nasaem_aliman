import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/sebha_zikr_entity.dart';
import '../../domain/usecases/sebha_usecases.dart';
import 'sebha_state.dart';

class SebaaCubit extends Cubit<SebhaState> {
  final GetAllSavedAzkar getAllSavedAzkar;
  final SaveZikr saveZikr;
  final UpdateZikr updateZikr;
  final DeleteZikr deleteZikr;
  final GetCurrentZikr getCurrentZikr;
  final SetCurrentZikr setCurrentZikr;
  final HasDefaultAzkarBeenAdded hasDefaultAzkarBeenAdded;
  final MarkDefaultAzkarAsAdded markDefaultAzkarAsAdded;

  SebaaCubit({
    required this.getAllSavedAzkar,
    required this.saveZikr,
    required this.updateZikr,
    required this.deleteZikr,
    required this.getCurrentZikr,
    required this.setCurrentZikr,
    required this.hasDefaultAzkarBeenAdded,
    required this.markDefaultAzkarAsAdded,
  }) : super(SebhaInitial());

  Future<void> loadSavedAzkar() async {
    try {
      emit(SebhaLoading());

      var savedAzkar = await getAllSavedAzkar();
      bool addedDefaults = false;

      // Only add default azkar if there are no saved ones AND they haven't been added before
      if (savedAzkar.isEmpty && !(await hasDefaultAzkarBeenAdded())) {
        await _addDefaultAzkar();
        await markDefaultAzkarAsAdded();
        savedAzkar = await getAllSavedAzkar();
        addedDefaults = true;
      }

      var currentZikr = await getCurrentZikr();

      // If we just added defaults and there's no current zikr, select the first one
      if (addedDefaults && currentZikr == null && savedAzkar.isNotEmpty) {
        await setCurrentZikr(savedAzkar.first.id);
        currentZikr = savedAzkar.first;
      }

      // If there are saved azkar but no current zikr selected, auto-select the first one
      if (currentZikr == null && savedAzkar.isNotEmpty) {
        await setCurrentZikr(savedAzkar.first.id);
        currentZikr = savedAzkar.first;
      }

      // Find current index based on current zikr
      int currentIndex = 0;
      if (currentZikr != null && savedAzkar.isNotEmpty) {
        final index = savedAzkar.indexWhere((z) => z.id == currentZikr!.id);
        if (index != -1) currentIndex = index;
      }

      emit(
        SebhaLoaded(
          savedAzkar: savedAzkar,
          currentZikr: currentZikr,
          currentIndex: currentIndex,
        ),
      );
    } catch (e) {
      emit(SebhaError('فشل في تحميل الأذكار المحفوظة: ${e.toString()}'));
    }
  }

  Future<void> addZikr(String text) async {
    try {
      final newZikr = SebhaZikrEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text,
        createdAt: DateTime.now(),
      );

      await saveZikr(newZikr);
      await setCurrentZikr(newZikr.id); // Auto-select the newly added zikr
      await loadSavedAzkar(); // Reload to get updated list
    } catch (e) {
      emit(SebhaError('فشل في إضافة الذكر: ${e.toString()}'));
    }
  }

  Future<void> editZikr(String id, String newText) async {
    try {
      if (state is SebhaLoaded) {
        final loadedState = state as SebhaLoaded;
        final zikrIndex = loadedState.savedAzkar.indexWhere((z) => z.id == id);

        if (zikrIndex != -1) {
          final existingZikr = loadedState.savedAzkar[zikrIndex];
          final updatedZikr = existingZikr.copyWith(text: newText);

          await updateZikr(updatedZikr);
          await loadSavedAzkar(); // Reload to get updated list
        }
      }
    } catch (e) {
      emit(SebhaError('فشل في تعديل الذكر: ${e.toString()}'));
    }
  }

  Future<void> removeZikr(String id) async {
    try {
      await deleteZikr(id);
      await loadSavedAzkar(); // Reload to get updated list
    } catch (e) {
      emit(SebhaError('فشل في حذف الذكر: ${e.toString()}'));
    }
  }

  Future<void> selectZikr(String zikrId) async {
    try {
      await setCurrentZikr(zikrId);

      if (state is SebhaLoaded) {
        final loadedState = state as SebhaLoaded;
        final selectedZikr = loadedState.savedAzkar.firstWhere(
          (z) => z.id == zikrId,
        );
        final newIndex = loadedState.savedAzkar.indexWhere(
          (z) => z.id == zikrId,
        );

        emit(
          loadedState.copyWith(
            currentZikr: selectedZikr,
            currentIndex: newIndex,
          ),
        );
      }
    } catch (e) {
      emit(SebhaError('فشل في اختيار الذكر: ${e.toString()}'));
    }
  }

  void navigateToIndex(int index) {
    if (state is SebhaLoaded) {
      final loadedState = state as SebhaLoaded;
      if (index >= 0 && index < loadedState.savedAzkar.length) {
        final selectedZikr = loadedState.savedAzkar[index];
        selectZikr(selectedZikr.id);
      }
    }
  }

  Future<void> incrementCounter() async {
    try {
      if (state is SebhaLoaded) {
        final loadedState = state as SebhaLoaded;
        if (loadedState.currentZikr != null) {
          final updatedZikr = loadedState.currentZikr!.copyWith(
            currentCount: loadedState.currentZikr!.currentCount + 1,
            lastUsedAt: DateTime.now(),
          );

          await updateZikr(updatedZikr);

          emit(loadedState.copyWith(currentZikr: updatedZikr));
        }
      }
    } catch (e) {
      emit(SebhaError('فشل في تحديث العداد: ${e.toString()}'));
    }
  }

  Future<void> resetCounter() async {
    try {
      if (state is SebhaLoaded) {
        final loadedState = state as SebhaLoaded;
        if (loadedState.currentZikr != null) {
          final resetZikr = loadedState.currentZikr!.copyWith(currentCount: 0);

          await updateZikr(resetZikr);

          emit(loadedState.copyWith(currentZikr: resetZikr));
        }
      }
    } catch (e) {
      emit(SebhaError('فشل في إعادة تعيين العداد: ${e.toString()}'));
    }
  }

  Future<void> clearCurrentZikr() async {
    try {
      await setCurrentZikr(null);

      if (state is SebhaLoaded) {
        final loadedState = state as SebhaLoaded;
        emit(loadedState.copyWith(clearCurrentZikr: true));
      }
    } catch (e) {
      emit(SebhaError('فشل في مسح الذكر الحالي: ${e.toString()}'));
    }
  }

  Future<void> _addDefaultAzkar() async {
    final defaultAzkar = [
      'سُبْحَانَ اللَّهِ',
      'الْحَمْدُ لِلَّهِ',
      'اللَّهُ أَكْبَرُ',
    ];

    final now = DateTime.now();
    for (int i = 0; i < defaultAzkar.length; i++) {
      final zikr = SebhaZikrEntity(
        id: '${now.millisecondsSinceEpoch}_$i',
        text: defaultAzkar[i],
        createdAt: now.add(
          Duration(milliseconds: i),
        ), // Slightly different timestamps
      );
      await saveZikr(zikr);
    }
  }
}
