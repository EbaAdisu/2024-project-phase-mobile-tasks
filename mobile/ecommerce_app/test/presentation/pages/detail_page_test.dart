import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/detail_page.dart';
import 'package:ecommerce_app/presentation/widgets/product_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Define a real ProductModel for testing
ProductModel createTestProduct() {
  return ProductModel(
    id: '1',
    name: 'Test Product',
    price: 99.99,
    description: 'This is a test product.',
    imageUrl: Urls.imageUrl,
  );
}

void main() {
  testWidgets('DetailPage displays product information correctly',
      (WidgetTester tester) async {
    // Create a real ProductModel instance
    final testProduct = createTestProduct();

    // Build the widget with the test product
    await tester.pumpWidget(
      MaterialApp(
        home: DetailPage(),
        // Provide the product model via ModalRoute
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            return MaterialPageRoute(
              builder: (context) => DetailPage(),
              settings: RouteSettings(arguments: testProduct),
            );
          }
          return null;
        },
      ),
    );

    // Verify that the product information is displayed correctly
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$99.99'), findsOneWidget);
    expect(find.text('This is a test product.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verify that the back button is present
    expect(find.byIcon(Icons.arrow_back_ios_new), findsOneWidget);

    // Verify the action buttons
    expect(find.widgetWithText(ProductActionButton, 'DELETE'), findsOneWidget);
    expect(find.widgetWithText(ProductActionButton, 'UPDATE'), findsOneWidget);
  });
}
