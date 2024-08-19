import 'dart:convert';

import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/platform/client.dart';
import 'package:ecommerce_app/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/json_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('delete product', () {
    const productId = '1';
    test('should return void when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.deleteProduct(
          productId,
        ),
      ).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          body: null,
        ),
      );
      // act
      await productRemoteDataSourceImpl.deleteProduct(productId);
      // assert
      verify(
        mockHttpClient.deleteProduct(
          productId,
        ),
      );
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.deleteProduct(productId),
        ).thenAnswer(
            (_) async => Future<HttpResponse>.error(ServerException()));
        // act
        final result = productRemoteDataSourceImpl.deleteProduct(productId);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
  group('get product', () {
    const productId = '1';
    test('should return product model when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.getProduct(productId),
      ).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          body: ProductModel.fromJson(
            json.decode(
              readJson('dummy_product_response.json'),
            )['data'],
          ),
        ),
      );
      // act
      final result = await productRemoteDataSourceImpl.getProduct(productId);
      // assert
      expect(result, isA<ProductModel>());
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.getProduct(productId),
      ).thenAnswer(
        (_) async => Future<HttpResponse>.error(ServerException()),
      );
      // act
      final result = productRemoteDataSourceImpl.getProduct(productId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('get all products', () {
    List<dynamic> jsonData =
        json.decode(readJson('dummy_products_response.json'))['data'];
    test('should return list of product model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.getProducts(),
      ).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          body: jsonData
              .map((jsonItem) => ProductModel.fromJson(jsonItem))
              .toList(),
        ),
      );
      // act
      final result = await productRemoteDataSourceImpl.getProducts();
      // assert
      // check if the result is a list of ProductModel and not empty
      debugPrint('Result: $result');
      expect(result, isA<List<ProductModel>>());
      expect(result.isNotEmpty, true);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.getProducts(),
        ).thenAnswer(
          (_) async => Future<HttpResponse>.error(ServerException()),
        );
        // act
        final result = productRemoteDataSourceImpl.getProducts();
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
  group('update product', () {
    const testProduct = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'http://example.com/image1',
    );
    test('should return product model when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.updateProduct(testProduct),
      ).thenAnswer(
        (_) async => HttpResponse(
          statusCode: 200,
          body: testProduct,
        ),
      );
      // act
      final result =
          await productRemoteDataSourceImpl.updateProduct(testProduct);
      // assert
      expect(result, isA<ProductModel>());
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.updateProduct(testProduct),
        ).thenAnswer(
          (_) async => Future<HttpResponse>.error(ServerException()),
        );
        // act
        final result = productRemoteDataSourceImpl.updateProduct(testProduct);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
