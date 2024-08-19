import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

class CreateProductEvent extends ProductEvent {
  final ProductEntity product;
  const CreateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String id;
  const DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetSingleProductEvent extends ProductEvent {
  final String id;
  const GetSingleProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadAllProductEvent extends ProductEvent {
  const LoadAllProductEvent();
  @override
  List<Object> get props => [];
}

class UpdateProductEvent extends ProductEvent {
  final ProductEntity product;
  const UpdateProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
