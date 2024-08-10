import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/usecases/update_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late UpdateProductUsecase updateProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    updateProductUsecase = UpdateProductUsecase(mockProductRepository);
  });
  const testproduct = Product(
    id: '1',
    name: 'product',
    price: 100,
    description: 'description',
    imageUrl: 'image_url',
  );
  test(
    'should call updateProduct from ProductRepository',
    () async {
      // arrange
      when(mockProductRepository.updateProduct(testproduct))
          .thenAnswer((_) async => const Right(testproduct));

      // act
      final result = await updateProductUsecase(testproduct);

      // assert
      expect(result, const Right(testproduct));
    },
  );
}
