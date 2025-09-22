part of 'sebha_cubit.dart';

abstract class SebhaState {}

class SebhaInitial extends SebhaState {}

class SebhaCountUpdated extends SebhaState {
  final int count;
  SebhaCountUpdated(this.count);
}
