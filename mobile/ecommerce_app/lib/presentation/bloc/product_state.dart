import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object> get props => [];
}

class InitialState extends ProductState {}

class LoadingState extends ProductState {}

class LoadedAllProductState extends ProductState {}

class LoadedSingleProductState extends ProductState {
  final ProductEntity product;
  const LoadedSingleProductState(this.product);

  @override
  List<Object> get props => [product];
}

class ErrorState extends ProductState {
  final String message;
  const ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
