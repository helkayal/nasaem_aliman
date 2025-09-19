import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/azkar.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  AzkarCubit() : super(AzkarInitial());

  void fetchAzkar() async {
    emit(AzkarLoading());

    // Simulate loading
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
    final azkar = [
      Zekr(text: "سبحان الله", category: "Morning"),
      Zekr(text: "الحمد لله", category: "Evening"),
      Zekr(text: "لا إله إلا الله", category: "Daily"),
    ];

    emit(AzkarLoaded(azkar));
  }
}
