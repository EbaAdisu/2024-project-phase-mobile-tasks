import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase {
  final ProductRepository productRepository;

  ViewAllProductsUsecase(this.productRepository);
  Future<Either<Failure, List<ProductEntity>>> call() async {
    return await productRepository.getProducts();
  }
}
