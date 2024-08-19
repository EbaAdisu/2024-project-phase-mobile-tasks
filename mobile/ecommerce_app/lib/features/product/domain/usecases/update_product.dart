import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase extends UseCase<ProductEntity, Params> {
  final ProductRepository productRepository;

  UpdateProductUsecase(this.productRepository);
  @override
  Future<Either<Failure, ProductEntity>> call(Params params) async {
    return await productRepository.updateProduct(params.product);
  }
}

class Params extends Equatable {
  final ProductEntity product;

  const Params({required this.product});
  @override
  List<Object?> get props => [product];
}
