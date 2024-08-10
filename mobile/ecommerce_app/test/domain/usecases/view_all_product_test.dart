import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/domain/entities/product.dart';
import 'package:ecommerce_app/domain/usecases/view_all_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late ViewAllProductsUsecase viewAllProductsUsecase;
  late MockProductRepository mockProductRepository;
  setUp(() {
    mockProductRepository = MockProductRepository();
    viewAllProductsUsecase = ViewAllProductsUsecase(mockProductRepository);
  });

  const testPoducts = [
    Product(
      id: '1',
      name: 'product',
      price: 100,
      description: 'description',
      imageUrl: 'image_url',
    ),
    Product(
      id: '2',
      name: 'product',
      price: 100,
      description: 'description',
      imageUrl: 'image_url',
    ),
  ];
  test(
    'should call getProducts from ProductRepository',
    () async {
      // arrange
      when(mockProductRepository.getProducts())
          .thenAnswer((_) async => const Right(testPoducts));

      // act
      final result = await viewAllProductsUsecase();

      // assert
      expect(result, const Right(testPoducts));
    },
  );
}
