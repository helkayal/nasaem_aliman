import 'package:flutter_bloc/flutter_bloc.dart';

part 'sebha_state.dart';

class SebhaCubit extends Cubit<SebhaState> {
  SebhaCubit() : super(SebhaInitial());

  int _count = 0;

  void incrementCounter() {
    _count++;
    emit(SebhaCountUpdated(_count));
  }

  void resetCounter() {
    _count = 0;
    emit(SebhaCountUpdated(_count));
  }
}
