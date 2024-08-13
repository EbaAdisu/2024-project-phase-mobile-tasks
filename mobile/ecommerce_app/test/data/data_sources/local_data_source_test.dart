import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/data/data_sources/local_data_source.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late ProductLocalDataSourceImpl productLocalDataSourceImpl;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    productLocalDataSourceImpl = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });
  group('get all products', () {
    final jsonList = json.decode(readJson('dummy_products_response.json'));
    final testProductModelList =
        (jsonList as List).map((e) => ProductModel.fromJson(e)).toList();
    const cachedProducts = 'CACHED_PRODUCTS';
    test('should return list of products when there are products in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(cachedProducts))
          .thenReturn(json.encode(jsonList));
      // act
      final result = await productLocalDataSourceImpl.getProducts();
      // assert
      expect(result, testProductModelList);
    });
    test('should throw CacheException when there is no product in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final result = productLocalDataSourceImpl.getProducts();
      // assert
      expect(result, throwsA(isA<CacheException>()));
    });
  });

  group('Cache all products', () {
    final jsonList = json.decode(readJson('dummy_products_response.json'));
    final testProductModelList =
        (jsonList as List).map((e) => ProductModel.fromJson(e)).toList();
    const cachedProducts = 'CACHED_PRODUCTS';

    test('should cache products when products are passed', () async {
      // arrenge
      when(mockSharedPreferences.setString(
              cachedProducts, json.encode(jsonList)))
          .thenAnswer(
        (_) async => true,
      );

      // act
      await productLocalDataSourceImpl.cacheProducts(testProductModelList);
      // assert
      verify(mockSharedPreferences.setString(
        cachedProducts,
        json.encode(testProductModelList.map((e) => e.toJson()).toList()),
      ));
    });
    // trow cache exception when there is an error
    test('should throw CacheException when there is an error', () async {
      // arrange
      when(mockSharedPreferences.setString(any, any)).thenThrow(Exception());
      // act
      final call = productLocalDataSourceImpl.cacheProducts;
      // assert
      expect(() => call(testProductModelList), throwsA(isA<CacheException>()));
    });
  });
}
