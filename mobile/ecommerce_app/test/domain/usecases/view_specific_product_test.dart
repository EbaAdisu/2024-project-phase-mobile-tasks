import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/usecases/view_specific_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ViewProductUsecase viewProductUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    viewProductUsecase = ViewProductUsecase(mockProductRepository);
  });
  const testproduct = Product(
    id: '1',
    name: 'product',
    price: 100,
    description: 'description',
    imageUrl: 'image_url',
  );
  const testPoductId = '1';
  test(
    'should call getProduct from ProductRepository',
    () async {
      // arrange
      when(mockProductRepository.getProduct(testPoductId))
          .thenAnswer((_) async => const Right(testproduct));

      // act
      final result = await viewProductUsecase(testPoductId);

      // assert
      expect(result, const Right(testproduct));
    },
  );
}