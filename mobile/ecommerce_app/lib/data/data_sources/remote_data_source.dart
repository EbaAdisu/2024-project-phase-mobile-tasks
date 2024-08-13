import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/constants.dart';
import '../../core/error/exception.dart';
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

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    final response = await client.post(
      Uri.parse(Urls.product()),
      body: product.toJson(),
    );
    if (response.statusCode == 201) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(
      Uri.parse(Urls.productId(id)),
    );
    if (response.statusCode == 204) {
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
    final response = await client.get(Uri.parse(Urls.product()));
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
    final response = await client.patch(
      Uri.parse(
        Urls.productId(product.id),
      ),
      body: product.toJson(),
    );
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw ServerException();
    }
  }
}

/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

class ImageTempRemoteDataSourceImpl {
  Future<ProductModel> createProduct(ProductModel product) async {
    var request = http.MultipartRequest('POST', Uri.parse(Urls.product()));

    request.fields['id'] = product.id;
    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['imageUrl'] = product.imageUrl;

    request.files
        .add(await http.MultipartFile.fromPath('image', product.imageUrl));

    var response = await request.send();

    if (response.statusCode == 201) {
      var responseData = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseData));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    var request =
        http.MultipartRequest('PUT', Uri.parse(Urls.product() + product.id));

    request.fields['id'] = product.id;
    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['imageUrl'] = product.imageUrl;

    request.files
        .add(await http.MultipartFile.fromPath('image', product.imageUrl));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return ProductModel.fromJson(json.decode(responseData));
    } else {
      throw ServerException();
    }
  }
}
