import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

// import '../../core/error/exception.dart';
import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/platform/network_info.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/local_data_source.dart';
import '../data_sources/remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  final ProductLocalDataSource productLocalDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.productRemoteDataSource,
    required this.productLocalDataSource,
  });

  @override
  Future<Either<Failure, ProductEntity>> createProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await productRemoteDataSource
            .createProduct(ProductModel.toModel(product));
        return Right(productModel);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failure'));
      }
    } else {
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await productRemoteDataSource.deleteProduct(id);
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failure'));
      }
    } else {
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> getProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await productRemoteDataSource.getProduct(id);
        return Right(product);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failure'));
      }
    } else {
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await productRemoteDataSource.getProducts();
        try {
          await productLocalDataSource.cacheProducts(products);
        } catch (e) {
          debugPrint('Cache product failure $e');
        }
        return Right(products);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failure'));
      }
    } else {
      try {
        final products = await productLocalDataSource.getProducts();
        return Right(products);
      } on CacheException {
        return const Left(CacheFailure('Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, ProductEntity>> updateProduct(
      ProductEntity product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = await productRemoteDataSource
            .updateProduct(ProductModel.toModel(product));
        return Right(productModel);
      } on ServerException {
        return const Left(ServerFailure('Server Failure'));
      } on SocketException {
        return const Left(ConnectionFailure('Connection Failure'));
      }
    } else {
      return const Left(ConnectionFailure('Connection Failure'));
    }
  }
}
