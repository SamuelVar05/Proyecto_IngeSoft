import 'package:chazapp/src/core/network/data_state.dart';
import 'package:chazapp/src/features/product_creation/domain/usecases/create_category.dart';
import 'package:chazapp/src/features/product_creation/domain/usecases/get_categories.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_event.dart';
import 'package:chazapp/src/features/product_creation/presentation/bloc/category/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CreateCategoryUseCase createCategoryUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoryBloc(this.createCategoryUseCase, this.getCategoriesUseCase)
      : super(CategoryInitialState()) {
    on<CreateCategoryEvent>(_onCreateCategoryEvent);
    on<GetCategoriesEvent>(_onGetCategoriesEvent);
  }

  Future<void> _onCreateCategoryEvent(
      CreateCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await createCategoryUseCase.call(params: {
      "name": event.name,
      "description": event.description,
      "token": event.token,
    });

    if (result is DataSuccess) {
      emit(CategoryCreatedState(result.data!));
    } else {
      emit(CategoryErrorState(result.exception!));
    }
  }

  Future<void> _onGetCategoriesEvent(
      GetCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoadingState());
    final result = await getCategoriesUseCase.call(
      params: event.token,
    );

    if (result is DataSuccess) {
      emit(CategoryLoadedState(result.data!));
    } else {
      emit(CategoryErrorState(result.exception!));
    }
  }
}
