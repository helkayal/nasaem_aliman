import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/asmaa.dart';

part 'asmaa_state.dart';

class AsmaaCubit extends Cubit<AsmaaState> {
  AsmaaCubit() : super(AsmaaInitial());

  void fetchNames() async {
    emit(AsmaaLoading());

    await Future.delayed(const Duration(seconds: 1));

    final names = [
      AllahName(arabic: "ٱلرَّحِيمُ", meaning: "The Merciful"),
      AllahName(arabic: "ٱلْمَلِكُ", meaning: "The King"),
      AllahName(arabic: "ٱلْقُدُّوسُ", meaning: "The Holy"),
      AllahName(arabic: "ٱلْخَالِقُ", meaning: "The Creator"),
    ];

    emit(AsmaaLoaded(names));
  }
}
