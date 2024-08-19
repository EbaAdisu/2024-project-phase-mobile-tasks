import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/create_product.dart' as create_usecase;
import '../../domain/usecases/delete_product.dart' as delete_usecase;
import '../../domain/usecases/update_product.dart' as update_usecase;
import '../../domain/usecases/view_all_product.dart' as view_all_usecase;
import '../../domain/usecases/view_specific_product.dart' as view_usecase;
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final create_usecase.CreateProductUsecase createProductUsecase;
  final delete_usecase.DeleteProductUsecase deleteProductUsecase;
  final view_usecase.ViewProductUsecase viewProductUsecase;
  final view_all_usecase.ViewAllProductsUsecase viewAllProductsUsecase;
  final update_usecase.UpdateProductUsecase updateProductUsecase;

  ProductBloc({
    required this.createProductUsecase,
    required this.deleteProductUsecase,
    required this.viewProductUsecase,
    required this.viewAllProductsUsecase,
    required this.updateProductUsecase,
  }) : super(InitialState()) {
    on<GetSingleProductEvent>((event, emit) async {
      emit(LoadingState());
      final result =
          await viewProductUsecase(view_usecase.Params(productId: event.id));
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (product) {
          emit(LoadedSingleProductState(product));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 300)));
    on<CreateProductEvent>(
      (event, emit) async {
        emit(LoadingState());
        final result = await createProductUsecase(
            create_usecase.Params(product: event.product));
        debugPrint('CreateProductEvent $result');
        result.fold(
          (failure) {
            emit(ErrorState(failure.message));
          },
          (product) {
            emit(LoadedSingleProductState(product));
          },
        );
      },
    );
    on<DeleteProductEvent>((event, emit) async {
      debugPrint('DeleteProductEvent');
      emit(LoadingState());
      final result = await deleteProductUsecase(
          delete_usecase.Params(productId: event.id));

      debugPrint('DeleteProductEvent $result');
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (success) {
          emit(InitialState());
        },
      );
    });

    on<LoadAllProductEvent>((event, emit) async {
      emit(LoadingState());
      // debugPrint('LoadAllProductEvent');
      final result = await viewAllProductsUsecase(NoParams());
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (products) {
          // debugPrint('LoadAllProductState $products');
          emit(LoadedAllProductState(products));
        },
      );
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(LoadingState());
      debugPrint('UpdateProductEvent');
      final result = await updateProductUsecase(
          update_usecase.Params(product: event.product));
      debugPrint('UpdateProductEvent $result');
      result.fold(
        (failure) {
          emit(ErrorState(failure.message));
        },
        (product) {
          emit(LoadedSingleProductState(product));
        },
      );
    });
  }
}

EventTransformer<GetSingleProductEvent> debounce<T>(Duration duration) {
  return (event, mapper) => event.debounceTime(duration).flatMap(mapper);
}
