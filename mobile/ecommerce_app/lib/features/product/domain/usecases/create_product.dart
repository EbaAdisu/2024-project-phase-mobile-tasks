import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class CreateProductUsecase extends UseCase<ProductEntity, Params> {
  final ProductRepository productRepository;

  CreateProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(Params params) async {
    return await productRepository.createProduct(params.product);
  }
}

class Params extends Equatable {
  final ProductEntity product;

  const Params({required this.product});
  @override
  List<Object?> get props => [product];
}
