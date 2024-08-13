import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late ProductRemoteDataSourceImpl productRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    productRemoteDataSourceImpl =
        ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('create product', () {
    const testProduct = ProductModel(
      id: '1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      imageUrl: 'http://example.com/image1',
    );
    test('should return product model when the response code is 201', () async {
      // arrange
      when(
        mockHttpClient.post(
          Uri.parse(Urls.Product()),
          body: testProduct.toJson(),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_product_response.json'),
          201,
        ),
      );
      // act
      final result =
          await productRemoteDataSourceImpl.createProduct(testProduct);
      // assert
      expect(result, testProduct);
    });
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.post(
            Uri.parse(Urls.Product()),
            body: testProduct.toJson(),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
        );
        // act
        final result = productRemoteDataSourceImpl.createProduct(testProduct);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
  group('delete product', () {
    const productId = '1';
    test('should return void when the response code is 204', () async {
      // arrange
      when(
        mockHttpClient.delete(
          Uri.parse(Urls.productId(productId)),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '',
          204,
        ),
      );
      // act
      await productRemoteDataSourceImpl.deleteProduct(productId);
      // assert
      verify(
        mockHttpClient.delete(
          Uri.parse(Urls.productId(productId)),
        ),
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
        mockHttpClient.get(Uri.parse(Urls.productId(productId))),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_product_response.json'),
          200,
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
        mockHttpClient.get(Uri.parse(Urls.productId(productId))),
      ).thenAnswer(
        (_) async => http.Response(
          'Something went wrong',
          404,
        ),
      );
      // act
      final result = productRemoteDataSourceImpl.getProduct(productId);
      // assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('get all products', () {
    test('should return list of product model when the response code is 200',
        () async {
      // arrange
      when(
        mockHttpClient.get(Uri.parse(Urls.Product())),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_products_response.json'),
          200,
        ),
      );
      // act
      final result = await productRemoteDataSourceImpl.getProducts();
      // assert
      expect(result, isA<List<ProductModel>>());
    });

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        when(
          mockHttpClient.get(Uri.parse(Urls.Product())),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
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
        mockHttpClient.patch(
          Uri.parse(Urls.productId(testProduct.id)),
          body: testProduct.toJson(),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_product_response.json'),
          200,
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
          mockHttpClient.patch(
            Uri.parse(Urls.productId(testProduct.id)),
            body: testProduct.toJson(),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Something went wrong',
            404,
          ),
        );
        // act
        final result = productRemoteDataSourceImpl.updateProduct(testProduct);
        // assert
        expect(result, throwsA(isA<ServerException>()));
      },
    );
  });
}
