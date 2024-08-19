import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/pages/detail_page.dart';
import 'package:ecommerce_app/presentation/widgets/product_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late ProductModel product;
  late MockNavigatorObserver mockNavigatorObserver;

  setUp(() {
    product = const ProductModel(
      id: '1',
      name: 'Test Product',
      price: 99.99,
      description: 'This is a test product.',
      imageUrl: 'https://example.com/product.jpg',
    );

    mockNavigatorObserver = MockNavigatorObserver();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: const DetailPage(),
      navigatorObservers: [mockNavigatorObserver],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return const DetailPage();
          },
          settings: RouteSettings(
            arguments: product,
          ),
        );
      },
    );
  }

  testWidgets('displays the correct product information',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Verify the product details are displayed correctly
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$99.99'), findsOneWidget);
    expect(find.text('This is a test product.'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    // final image = tester.widget<Image>(find.byType(Image));
    // expect((image.image as NetworkImage).url,
    //     equals('https://example.com/product.jpg'));
  });

  testWidgets('navigates back when back button is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Tap the back button
    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    // Verify navigation was called
    verify(() => mockNavigatorObserver.didPop(any(), any())).called(1);
  });

  testWidgets('displays the ProductActionButton widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Verify the presence of DELETE and UPDATE buttons
    expect(find.byType(ProductActionButton), findsNWidgets(2));
    expect(find.text('DELETE'), findsOneWidget);
    expect(find.text('UPDATE'), findsOneWidget);
  });
}
