import 'package:dartz/dartz.dart';

import '../entities/error/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository productRepository;

  DeleteProductUsecase(this.productRepository);

  Future<Either<Failure, void>> call(String productId) async {
    return await productRepository.deleteProduct(productId);
  }
}
