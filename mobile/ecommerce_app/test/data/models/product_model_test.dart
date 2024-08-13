import 'dart:convert';

import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testProductModel = ProductModel(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 100.0,
    imageUrl: 'http://example.com/image1',
  );
  test('Should be subclas of product entity', () async {
    // assert
    expect(testProductModel, isA<ProductEntity>());
  });

  test(
    'should return a valid model from json',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson(
          'dummy_product_response.json',
        ),
      )['data'];

      // act
      final result = ProductModel.fromJson(jsonMap);

      // assert
      expect(result, equals(testProductModel));
    },
  );
  test(
    'should return a json map containing proper data',
    () async {
      // act
      final result = testProductModel.toJson();
      // assert
      final expectedJsonMap = {
        'id': '1',
        'name': 'Product 1',
        'description': 'Description 1',
        'price': 100.0,
        'imageUrl': 'http://example.com/image1',
      };

      expect(result, expectedJsonMap);
    },
  );
}
