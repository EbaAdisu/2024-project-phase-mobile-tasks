import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  final ProductRepository productRepository;

  ViewAllProductsUsecase(this.productRepository);
  Future<Either<Failure, List<Product>>> call() async {
    return await productRepository.getProducts();
  }
}
