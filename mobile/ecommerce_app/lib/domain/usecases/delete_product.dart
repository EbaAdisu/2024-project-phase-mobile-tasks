import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase extends UseCase<void, Params> {
  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await productRepository.deleteProduct(params.productId);
  }
}

class Params extends Equatable {
  final String productId;

  Params({required this.productId});

  @override
  List<Object?> get props => [id];
}
