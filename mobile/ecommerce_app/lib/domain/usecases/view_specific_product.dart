import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase extends UseCase<ProductEntity, Params> {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  @override
  Future<Either<Failure, ProductEntity>> call(Params params) async {
    return await productRepository.getProduct(params.productId);
  }
}

class Params extends Equatable {
  final String productId;

  const Params({required this.productId});
  @override
  List<Object?> get props => [productId];
}
