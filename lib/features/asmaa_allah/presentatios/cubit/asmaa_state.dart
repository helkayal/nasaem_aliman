part of 'asmaa_cubit.dart';

abstract class AsmaaState {}

class AsmaaInitial extends AsmaaState {}

class AsmaaLoading extends AsmaaState {}

class AsmaaLoaded extends AsmaaState {
  final List<AllahName> names;
  AsmaaLoaded(this.names);
}

class AsmaaError extends AsmaaState {
  final String message;
  AsmaaError(this.message);
}
