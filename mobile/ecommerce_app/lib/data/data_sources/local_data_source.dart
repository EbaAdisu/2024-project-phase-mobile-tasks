import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exception.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<void> cacheProducts(List<ProductModel> posts);
}

const cachedProducts = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    try {
      final jsonProducts =
          json.encode(products.map((e) => e.toJson()).toList());
      final result =
          await sharedPreferences.setString(cachedProducts, jsonProducts);
      if (result == false) throw CacheException();
      return;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final jsonString = sharedPreferences.getString(cachedProducts);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw CacheException();
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
