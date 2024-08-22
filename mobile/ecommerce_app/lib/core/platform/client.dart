import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exception.dart';
import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/product/data/models/product_model.dart';

abstract class Client {
  Future<HttpResponse> createProduct(ProductModel product);
  Future<HttpResponse> deleteProduct(String id);
  Future<HttpResponse> getProduct(String id);
  Future<HttpResponse> getProducts();
  Future<HttpResponse> updateProduct(ProductModel product);
}

class HttpResponse {
  final int statusCode;
  final dynamic body;

  HttpResponse({
    required this.statusCode,
    required this.body,
  });
}

class ClientImpl extends Client {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  ClientImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<HttpResponse> createProduct(ProductModel product) async {
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
      // add header
      request.headers['authorization'] = await authLocalDataSource.getToken();
    } catch (e) {
      debugPrint('Error adding image file: $e');
      throw ImageUploadException();
    }

    var response = await request.send();
    // debugPrint('Create remote data source: ${response.reasonPhrase}');

    if (response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      ProductModel product =
          ProductModel.fromJson(json.decode(responseData)['data']);
      debugPrint('Create remote data source: $product');
      return HttpResponse(
        statusCode: response.statusCode,
        body: product,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HttpResponse> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse(Urls.productId(id)),
      headers: {
        'Content-Type': 'application/json',
        'authorization': await authLocalDataSource.getToken(),
      },
    );
    if (response.statusCode == 200) {
      return HttpResponse(
        statusCode: response.statusCode,
        body: null,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HttpResponse> getProduct(String id) async {
    final response = await client.get(Uri.parse(Urls.productId(id)), headers: {
      'Content-Type': 'application/json',
      'authorization': await authLocalDataSource.getToken(),
    });
    if (response.statusCode == 200) {
      ProductModel product =
          ProductModel.fromJson(json.decode(response.body)['data']);
      return HttpResponse(
        statusCode: response.statusCode,
        body: product,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HttpResponse> getProducts() async {
    debugPrint('getProducts remote data source');
    final response = await client.get(Uri.parse(Urls.product()), headers: {
      'Content-Type': 'application/json',
      'authorization': await authLocalDataSource.getToken(),
    });
    // debugPrint(
    //     'getProducts remote data source response: ${json.decode(response.body)['data']}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body)['data'];
      List<ProductModel> products =
          jsonData.map((jsonItem) => ProductModel.fromJson(jsonItem)).toList();
      return HttpResponse(
        statusCode: response.statusCode,
        body: products,
      );
    } else {
      throw ServerException();
    }
  }

  @override
  Future<HttpResponse> updateProduct(ProductModel product) async {
    // debugPrint('Update remote data source: $product');

    final response = await client.put(
      Uri.parse(
        Urls.productId(product.id),
      ),
      body: jsonEncode(product.toJson()),
      headers: {
        'Content-Type': 'application/json',
        'authorization': await authLocalDataSource.getToken(),
      },
    );
    if (response.statusCode == 200) {
      ProductModel product =
          ProductModel.fromJson(json.decode(response.body)['data']);
      return HttpResponse(
        statusCode: response.statusCode,
        body: product,
      );
    } else {
      debugPrint('Update remote data source: ${response.body}');
      throw ServerException();
    }
  }
}
