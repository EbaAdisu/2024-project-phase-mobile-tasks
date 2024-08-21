import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    when(() => mockProductBloc.state).thenReturn(InitialState());
  });

  group('ProductActionButton Tests', () {
    testWidgets(
        'Should dispatch DeleteProductEvent and navigate on DELETE action',
        (WidgetTester tester) async {
      const product = ProductModel(
          id: '1',
          name: 'Product',
          description: 'Description',
          price: 10.0,
          imageUrl: 'http://example.com/image.png');

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<ProductBloc>(
            create: (context) => mockProductBloc,
            child: const Scaffold(
              body: ProductActionButton(
                action: 'DELETE',
                product: product,
              ),
            ),
          ),
        ),
      );

      // Tap the button to trigger the DELETE action
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify DeleteProductEvent is added to the bloc
      verify(() => mockProductBloc.add(DeleteProductEvent(product.id)))
          .called(1);

      // Verify navigation
      expect(find.byType(Navigator), findsOneWidget);
    });

    testWidgets('Should apply correct button style for DELETE action',
        (WidgetTester tester) async {
      const product = ProductModel(
          id: '1',
          name: 'Product',
          description: 'Description',
          price: 10.0,
          imageUrl: 'http://example.com/image.png');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductActionButton(
              action: 'DELETE',
              product: product,
            ),
          ),
        ),
      );

      // Check the button styling
      final button = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(button);
      expect(buttonWidget.style!.backgroundColor!.resolve({}), Colors.white);
      expect(buttonWidget.style!.side!.resolve({}),
          const BorderSide(color: Colors.red, width: 2));
    });

    testWidgets('Should apply correct button style for non-DELETE action',
        (WidgetTester tester) async {
      const product = ProductModel(
          id: '1',
          name: 'Product',
          description: 'Description',
          price: 10.0,
          imageUrl: 'http://example.com/image.png');

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductActionButton(
              action: 'UPDATE',
              product: product,
            ),
          ),
        ),
      );

      // Check the button styling
      final button = find.byType(ElevatedButton);
      final buttonWidget = tester.widget<ElevatedButton>(button);
      expect(buttonWidget.style!.backgroundColor!.resolve({}), Colors.blue);
      expect(buttonWidget.style!.side!.resolve({}),
          const BorderSide(color: Colors.blue, width: 2));
    });
  });
}
