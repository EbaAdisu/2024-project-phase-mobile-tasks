import 'dart:io';

import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('ProductCard widget test', (WidgetTester tester) async {
    final product = ProductModel(
      id: '1',
      imageUrl: Urls.imageUrl,
      name: 'Sample Product',
      price: 29.99,
      description: 'A sample product description.',
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(child: ProductCard(product: product)),
            ],
          ),
        ),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);

    expect(find.text('Sample Product'), findsOneWidget);
    expect(find.text('\$29.99'), findsOneWidget);
  });
}
