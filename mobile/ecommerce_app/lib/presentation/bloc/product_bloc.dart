import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/view_specific_product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ViewProductUsecase _viewProductUsecase;
  ProductBloc(this._viewProductUsecase) : super(InitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result = await _viewProductUsecase(Params(productId: event.id));
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (product) {
          emit(LoadedSingleProductState(product));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 300)));
  }
}

EventTransformer<GetSingleProductEvent> debounce<T>(Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
