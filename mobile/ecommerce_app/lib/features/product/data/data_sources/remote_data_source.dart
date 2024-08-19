import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel> createProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<ProductModel> getProduct(String id);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> updateProduct(ProductModel product);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

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
    debugPrint('Create remote data source: $product');
    var request = http.MultipartRequest('POST', Uri.parse(Urls.product()));

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    try {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          product.imageUrl,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    } catch (e) {
      debugPrint('Error adding image file: $e');
      throw ImageUploadException();
    }

    var response = await request.send();
    debugPrint('Create remote data source: ${response.reasonPhrase}');

    if (response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseData)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse(Urls.productId(id)),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> getProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.productId(id)));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    debugPrint('getProducts remote data source');
    final response = await client.get(Uri.parse(Urls.product()));
    // debugPrint(
    //     'getProducts remote data source response: ${json.decode(response.body)['data']}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      return jsonData
          .map((jsonItem) => ProductModel.fromJson(jsonItem))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    // debugPrint('Update remote data source: $product');

    final response = await client.put(
      Uri.parse(
        Urls.productId(product.id),
      ),
      body: jsonEncode(product.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      debugPrint('Update remote data source: ${response.body}');
      throw ServerException();
    }
  }
}
