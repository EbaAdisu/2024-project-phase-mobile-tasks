import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/usecases/delete_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late DeleteProductUsecase deleteProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    deleteProductUsecase = DeleteProductUsecase(mockProductRepository);
  });

  const testPoductId = '1';
  test(
    'should call deleteProduct from ProductRepository',
    () async {
      // arrange
      when(mockProductRepository.deleteProduct(testPoductId))
          .thenAnswer((_) async => const Right(null));

      // act
      final result = await deleteProductUsecase(testPoductId);

      // assert
      expect(result, const Right(null));
    },
  );
}
