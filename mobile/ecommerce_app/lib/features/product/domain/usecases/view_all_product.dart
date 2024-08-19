import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class ViewAllProductsUsecase extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository productRepository;

  ViewAllProductsUsecase(this.productRepository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(NoParams params) async {
    return await productRepository.getProducts();
  }
}
