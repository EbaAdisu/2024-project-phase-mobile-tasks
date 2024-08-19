import 'package:flutter/material.dart';
import '../../../../core/platform/client.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> createProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProduct(String id);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> updateProduct(ProductModel product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  // final http.Client client;
  final Client client;

  ProductRemoteDataSourceImpl({required this.client});

  // @override
  // Future<ProductModel> createProduct(ProductModel product) async {
  //   final response = await client.post(
  //     Uri.parse(Urls.product()),
  //     body: product.toJson(),
  //   );
  //   if (response.statusCode == 201) {
  //     return ProductModel.fromJson(json.decode(response.body)['data']);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      HttpResponse result = await client.createProduct(product);
      return ProductModel.fromJson(result.body);
    } catch (e) {
      debugPrint('Error adding image file: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await client.deleteProduct(id);
      return;
    } catch (e) {
      debugPrint('Error deleting product: $e');
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    try {
      final response = await client.getProduct(id);
      return response.body;
    } catch (e) {
      debugPrint('Error getting product: $e');
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.getProducts();
      // turn it in to a list of product model
      return response.body;
    } catch (e) {
      debugPrint('Error getting products: $e');
      rethrow;
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      HttpResponse result = await client.updateProduct(product);
      return result.body;
    } catch (e) {
      debugPrint('Error updating product: $e');
      rethrow;
    }
  }
}
