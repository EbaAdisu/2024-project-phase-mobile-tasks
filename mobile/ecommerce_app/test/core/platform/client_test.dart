import 'dart:convert';

import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/platform/client.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ClientImpl clientImpl;
  late MockAuthLocalDataSource mockAuthLocalDataSource;
  setUp(() {
    mockHttpClient = MockHttpClient();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    clientImpl = ClientImpl(
      client: mockHttpClient,
      authLocalDataSource: mockAuthLocalDataSource,
    );
  });

  group('delete product', () {
    const productId = '1';

    test('should return void when the response code is 200', () async {
      // arrange
      when(
        mockHttpClient.delete(
          Uri.parse(Urls.productId(productId)),
          headers: {
            'Content-Type': 'application/json',
            'authorization': await mockAuthLocalDataSource.getToken(),
          },
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '',
          200,
        ),
      );
      when(
        mockAuthLocalDataSource.getToken(),
      ).thenAnswer(
        (_) async => 'token',
      );

      // act
      await clientImpl.deleteProduct(productId);
      // assert
      verify(
        mockHttpClient.delete(any),
      );
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.delete(
            Uri.parse(Urls.productId(productId)),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
        );
        // act
        final result = clientImpl.deleteProduct(productId);
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
        mockHttpClient.get(Uri.parse(Urls.productId(productId))),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_product_response.json'),
          200,
        ),
      );
      // act
      final result = await clientImpl.getProduct(productId);
      // assert
      expect(result.body, isA<ProductModel>());
      expect(result.statusCode, 200);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.productId(productId))),
      ).thenAnswer(
        (_) async => http.Response(
          'Something went wrong',
          404,
        ),
      );
      // act
      final result = clientImpl.getProduct(productId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('get all products', () {
    test('should return list of product model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.product())),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_products_response.json'),
          200,
        ),
      );
      // act
      final result = await clientImpl.getProducts();
      // assert
      // check if the result is a list of ProductModel and not empty
      expect(result.body, isA<List<ProductModel>>());
      expect(result.body.isNotEmpty, true);
      expect(result.statusCode, 200);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.product())),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
        );
        // act
        final result = clientImpl.getProducts();
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
        mockHttpClient.put(
          Uri.parse(Urls.productId(testProduct.id)),
          body: jsonEncode(testProduct.toJson()),
          headers: {'Content-Type': 'application/json'},
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_product_response.json'),
          200,
        ),
      );
      // act
      final result = await clientImpl.updateProduct(testProduct);
      // assert
      expect(result.body, isA<ProductModel>());
      expect(result.statusCode, 200);
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.put(
            Uri.parse(Urls.productId(testProduct.id)),
            body: jsonEncode(testProduct.toJson()),
            headers: {'Content-Type': 'application/json'},
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
        );
        // act
        final result = clientImpl.updateProduct(testProduct);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
