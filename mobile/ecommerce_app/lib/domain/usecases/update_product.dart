import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProductUsecase {
  final ProductRepository productRepository;

  UpdateProductUsecase(this.productRepository);
  Future<Either<Failure, Product>> call(Product product) async {
    return await productRepository.updateProduct(product);
  }
}
