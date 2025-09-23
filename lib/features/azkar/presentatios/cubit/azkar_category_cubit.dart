import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_azkar_categories.dart';
import 'azkar_category_state.dart';

class AzkarCategoriesCubit extends Cubit<AzkarCategoriesState> {
  final GetAzkarCategories getAzkarCategories;

  AzkarCategoriesCubit(this.getAzkarCategories)
    : super(AzkarCategoriesInitial());

  Future<void> loadAzkarCategories() async {
    emit(AzkarCategoriesLoading());
    try {
      final azkar = await getAzkarCategories();
      emit(AzkarCategoriesLoaded(azkar));
    } catch (e) {
      emit(AzkarCategoriesError(e.toString()));
    }
  }
}
