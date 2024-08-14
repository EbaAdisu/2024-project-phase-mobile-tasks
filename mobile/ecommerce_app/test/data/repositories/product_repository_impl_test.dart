import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/exception.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/data/repositories/product_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockProductRemoteDataSource mockProductRemoteDataSource;
  late MockProductLocalDataSource mockProductLocalDataSource;
  late ProductRepositoryImpl productRepositoryImpl;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockProductRemoteDataSource = MockProductRemoteDataSource();
    mockProductLocalDataSource = MockProductLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    productRepositoryImpl = ProductRepositoryImpl(
      networkInfo: mockNetworkInfo,
      productRemoteDataSource: mockProductRemoteDataSource,
      productLocalDataSource: mockProductLocalDataSource,
    );
  });

  group('createProduct', () {
    const testProductModel = ProductModel(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: 'Description 1',
      imageUrl: 'image1.jpg',
    );
    test(
        'should return product when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.createProduct(testProductModel))
          .thenAnswer((_) async => testProductModel);
      // act
      final result =
          await productRepositoryImpl.createProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.createProduct(testProductModel));
      expect(result, const Right(testProductModel));
    });

    test('should return ConnectionFailure when networkInfo is not connected',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result =
          await productRepositoryImpl.createProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
    test(
        'should return ServerFailure on server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.createProduct(testProductModel))
          .thenThrow(ServerException());
      // act
      final result =
          await productRepositoryImpl.createProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.createProduct(testProductModel));
      expect(result, const Left(ServerFailure('Server Failure')));
    });
    // socket exception
    test(
        'should return ConnectionFailure on socket exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.createProduct(testProductModel))
          .thenThrow(const SocketException('Connection Failure'));
      // act
      final result =
          await productRepositoryImpl.createProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.createProduct(testProductModel));
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
  });

  group('deleteProduct', () {
    const productId = '1';
    test('should return void when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      final result = await productRepositoryImpl.deleteProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.deleteProduct(productId));
      expect(result, const Right(null));
    });

    test('should return ConnectionFailure when networkInfo is not connected',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await productRepositoryImpl.deleteProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
    test(
        'should return ServerFailure on server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.deleteProduct(productId))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.deleteProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.deleteProduct(productId));
      expect(result, const Left(ServerFailure('Server Failure')));
    });
    // socket exception
    test(
        'should return ConnectionFailure on socket exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.deleteProduct(productId))
          .thenThrow(const SocketException('Connection Failure'));
      // act
      final result = await productRepositoryImpl.deleteProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.deleteProduct(productId));
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
  });
  group('getProduct', () {
    const productId = '1';
    const testProductModel = ProductModel(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: 'Description 1',
      imageUrl: 'image1.jpg',
    );
    test(
        'should return product when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProduct(productId))
          .thenAnswer((_) async => testProductModel);
      // act
      final result = await productRepositoryImpl.getProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProduct(productId));
      expect(result, const Right(testProductModel));
    });

    test('should return ConnectionFailure when networkInfo is not connected',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await productRepositoryImpl.getProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
    test(
        'should return ServerFailure on server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProduct(productId))
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.getProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProduct(productId));
      expect(result, const Left(ServerFailure('Server Failure')));
    });
    // socket exception
    test(
        'should return ConnectionFailure on socket exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProduct(productId))
          .thenThrow(const SocketException('Connection Failure'));
      // act
      final result = await productRepositoryImpl.getProduct(productId);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProduct(productId));
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
  });

  //  group of tests for getProducts
  group('getProducts', () {
    const testProductModelList = [
      ProductModel(
        id: '1',
        name: 'Product 1',
        price: 100,
        description: 'Description 1',
        imageUrl: 'image1.jpg',
      ),
      ProductModel(
        id: '2',
        name: 'Product 2',
        price: 200,
        description: 'Description 2',
        imageUrl: 'image2.jpg',
      ),
    ];
    test(
        'should return list of products when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProducts())
          .thenAnswer((_) async => testProductModelList);
      // act
      final result = await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProducts());
      expect(result, const Right(testProductModelList));
    });
    test(
        'should cache the data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProducts())
          .thenAnswer((_) async => testProductModelList);
      // act
      await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProducts());
      verify(mockProductLocalDataSource.cacheProducts(testProductModelList));
    });
    test(
        'should return cached products when network is not connected and there is cached data',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockProductLocalDataSource.getProducts())
          .thenAnswer((_) async => testProductModelList);
      // act
      final result = await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      verify(mockProductLocalDataSource.getProducts());
      expect(result, const Right(testProductModelList));
    });

    // should return server failure on server exception when network is connected
    test(
        'should return ServerFailure on server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProducts())
          .thenThrow(ServerException());
      // act
      final result = await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProducts());
      expect(result, const Left(ServerFailure('Server Failure')));
    });

    // should return connection failure on socket exception when network is connected
    test(
        'should return ConnectionFailure on socket exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.getProducts())
          .thenThrow(const SocketException('Connection Failure'));
      // act
      final result = await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.getProducts());
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
    // return cache failure on cache exception when network is not connected
    test(
        'should return CacheFailure on cache exception when the call to local data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockProductLocalDataSource.getProducts())
          .thenThrow(CacheException());
      // act
      final result = await productRepositoryImpl.getProducts();
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      verify(mockProductLocalDataSource.getProducts());
      expect(result, const Left(CacheFailure('Cache Failure')));
    });
  });

  group('updateProduct', () {
    const testProductModel = ProductModel(
      id: '1',
      name: 'Product 1',
      price: 100,
      description: 'Description 1',
      imageUrl: 'image1.jpg',
    );
    test(
        'should return product when the call to remote data source is successful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.updateProduct(testProductModel))
          .thenAnswer((_) async => testProductModel);
      // act
      final result =
          await productRepositoryImpl.updateProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.updateProduct(testProductModel));
      expect(result, const Right(testProductModel));
    });

    test('should return ConnectionFailure when networkInfo is not connected',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result =
          await productRepositoryImpl.updateProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockProductRemoteDataSource);
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
    test(
        'should return ServerFailure on server exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.updateProduct(testProductModel))
          .thenThrow(ServerException());
      // act
      final result =
          await productRepositoryImpl.updateProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.updateProduct(testProductModel));
      expect(result, const Left(ServerFailure('Server Failure')));
    });
    // socket exception
    test(
        'should return ConnectionFailure on socket exception when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockProductRemoteDataSource.updateProduct(testProductModel))
          .thenThrow(const SocketException('Connection Failure'));
      // act
      final result =
          await productRepositoryImpl.updateProduct(testProductModel);
      // assert
      verify(mockNetworkInfo.isConnected);
      verify(mockProductRemoteDataSource.updateProduct(testProductModel));
      expect(result, const Left(ConnectionFailure('Connection Failure')));
    });
  });
}
