import 'dart:io';

import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/detail_page.dart';
import 'package:ecommerce_app/presentation/pages/update_page.dart';
import 'package:ecommerce_app/presentation/widgets/form_button.dart';
import 'package:ecommerce_app/presentation/widgets/form_text_field.dart';
import 'package:ecommerce_app/presentation/widgets/product_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Define a real ProductModel for testing

void main() {
  setUp(() {
    HttpOverrides.global = null;
  });
  testWidgets('UpdatePage test', (WidgetTester tester) async {
    final product = ProductModel(
      id: '1',
      name: 'Test Product',
      description: 'This is a test product',
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
                        builder: (BuildContext context) => UpdatePage(),
                        settings: RouteSettings(arguments: product),
                      ),
                    );
                  },
                  child: const Text('Open UpdatePage'),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open UpdatePage'));
    await tester.pumpAndSettle();

    expect(find.text('Update Product'), findsOneWidget);
    expect(find.widgetWithText(FormTextField, 'name'), findsOneWidget);
    expect(find.widgetWithText(FormTextField, 'price'), findsOneWidget);
    expect(find.widgetWithText(FormTextField, 'description'), findsOneWidget);
    expect(find.widgetWithText(FormButton, 'UPDATE'), findsOneWidget);
    expect(find.widgetWithText(FormButton, 'CANCEL'), findsOneWidget);
  });
}
