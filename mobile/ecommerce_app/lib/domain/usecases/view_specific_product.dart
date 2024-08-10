import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewProductUsecase {
  final ProductRepository productRepository;

  ViewProductUsecase(this.productRepository);

  Future<Either<Failure, Product>> call(String productId) async {
    return await productRepository.getProduct(productId);
  }
}
