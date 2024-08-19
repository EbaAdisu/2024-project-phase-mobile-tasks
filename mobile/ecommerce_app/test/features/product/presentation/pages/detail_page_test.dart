import 'dart:io';

import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/presentation/pages/detail_page.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Define a real ProductModel for testing

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });

  testWidgets('DetailPage test', (WidgetTester tester) async {
    const product = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'This is a test product.',
      price: 10.0,
      imageUrl: 'http://example.com/image.jpg',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Builder(
            builder: (BuildContext context) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailPage(),
                        settings: RouteSettings(arguments: product),
                      ),
                    );
                  },
                  child: const Text('Open DetailPage'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open DetailPage'));
    await tester.pumpAndSettle();

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$10.0'), findsOneWidget);
    expect(find.text('This is a test product.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify that the back button is present
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

    // Verify the action buttons
    expect(find.widgetWithText(ProductActionButton, 'DELETE'), findsOneWidget);
    expect(find.widgetWithText(ProductActionButton, 'UPDATE'), findsOneWidget);
  });
}
