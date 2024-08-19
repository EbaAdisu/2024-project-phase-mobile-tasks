import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/presentation/widgets/form_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockProductBloc extends Mock implements ProductBloc {}

void main() {
  late ProductBloc mockProductBloc;
  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  Widget testableWidget({
    required String buttonText,
    TextEditingController? nameController,
    TextEditingController? priceController,
    TextEditingController? descriptionController,
    TextEditingController? imageUrlController,
    GlobalKey<FormState>? formKey,
    ProductModel? product,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ProductBloc>.value(
          value: mockProductBloc,
          child: FormButton(
            text: buttonText,
            nameController: nameController,
            priceController: priceController,
            descriptionController: descriptionController,
            imageUrlController: imageUrlController,
            formKey: formKey,
            product: product,
          ),
        ),
      ),
    );
  }

  group('FormButton Widget Tests with state', () {
    setUp(() {
      mockProductBloc = MockProductBloc();
    });
    const product = ProductModel(
      id: '1',
      name: 'Old Product',
      description: 'Old Description',
      price: 5.0,
      imageUrl: 'http://example.com/old_image.jpg',
    );

    testWidgets('Update button triggers UpdateProductEvent and navigation',
        (WidgetTester tester) async {
      final nameController = TextEditingController(text: 'Test Product');
      final priceController = TextEditingController(text: '10.0');
      final descriptionController =
          TextEditingController(text: 'Test Description');
      final imageUrlController =
          TextEditingController(text: 'http://example.com/image.jpg');
      final formKey = GlobalKey<FormState>();

      whenListen(
        mockProductBloc,
        Stream.fromIterable([const LoadedSingleProductState(product)]),
        initialState: InitialState(),
      );

      await tester.pumpWidget(
        testableWidget(
          buttonText: 'UPDATE',
          nameController: nameController,
          priceController: priceController,
          descriptionController: descriptionController,
          imageUrlController: imageUrlController,
          formKey: formKey,
          product: product,
        ),
        // MaterialApp(
        //   home: Scaffold(
        //     body: BlocProvider<ProductBloc>.value(
        //       value: mockProductBloc,
        //       child: FormButton(
        //         text: 'UPDATE',
        //         nameController: nameController,
        //         priceController: priceController,
        //         descriptionController: descriptionController,
        //         imageUrlController: imageUrlController,
        //         formKey: formKey,
        //         product: product,
        //       ),
        //     ),
        //   ),
        // ),
      );

      // Simulate button press
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(() => mockProductBloc.add(const UpdateProductEvent(
            ProductModel(
              id: '1',
              name: 'Test Product',
              description: 'Test Description',
              price: 10.0,
              imageUrl: 'http://example.com/old_image.jpg',
            ),
          ))).called(1);
    });
  });
  group('FormButton Widget Tests only ui', () {
    testWidgets('FormButton displays correct text',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        testableWidget(buttonText: 'ADD'),
      );

      // Verify the button displays the correct text
      expect(find.text('ADD'), findsOneWidget);
    });

    testWidgets('FormButton displays cancel text correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        testableWidget(buttonText: 'CANCEL'),
      );

      // Verify the button displays the correct text
      expect(find.text('CANCEL'), findsOneWidget);
    });

    group('Button Styles', () {
      testWidgets('FormButton with text "CANCEL" has correct styles',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          testableWidget(buttonText: 'CANCEL'),
        );

        final ElevatedButton elevatedButton =
            tester.widget(find.byType(ElevatedButton));
        final ButtonStyle buttonStyle = elevatedButton.style!;

        // Check button background color
        expect(buttonStyle.backgroundColor!.resolve({}), Colors.white);

        // Check button border color
        expect(
          (buttonStyle.side!.resolve({}) as BorderSide).color,
          Colors.red,
        );

        // Check text color
        final Text textWidget = tester.widget(find.byType(Text));
        expect(textWidget.style?.color, Colors.red);
      });

      testWidgets('FormButton with text "Submit" has correct styles',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          testableWidget(buttonText: 'Submit'),
        );

        final ElevatedButton elevatedButton =
            tester.widget(find.byType(ElevatedButton));
        final ButtonStyle buttonStyle = elevatedButton.style!;

        // Check button background color
        expect(buttonStyle.backgroundColor!.resolve({}), Colors.blue.shade700);

        // Check button border color
        expect(
          (buttonStyle.side!.resolve({}) as BorderSide).color,
          Colors.blue.shade700,
        );

        // Check text color
        final Text textWidget = tester.widget(find.byType(Text));
        expect(textWidget.style?.color, Colors.white);
      });
    });
  });
}
