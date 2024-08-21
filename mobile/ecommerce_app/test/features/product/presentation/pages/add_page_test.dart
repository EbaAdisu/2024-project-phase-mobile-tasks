// test/add_page_test.dart

import 'dart:io';

import 'package:ecommerce_app/features/product/presentation/pages/add_page.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockXFile extends Mock implements XFile {}

class MockDirectory extends Mock implements Directory {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockXFile());
  });

  Future<void> pumpAddPage(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AddPage(),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('add page ', () {
    testWidgets('renders all UI components correctly', (tester) async {
      await pumpAddPage(tester);

      expect(find.text('Add Product'), findsOneWidget);
      expect(find.byType(GestureDetector), findsWidgets);
      expect(find.byType(FormTextField), findsWidgets);
      expect(find.text('ADD'), findsOneWidget);
      expect(find.text('CANCEL'), findsOneWidget);
    });

    testWidgets('allows text input in form fields', (tester) async {
      await pumpAddPage(tester);

      await tester.enterText(
          find.byWidgetPredicate(
              (widget) => widget is FormTextField && widget.text == 'name'),
          'Test Product');
      await tester.enterText(
          find.byWidgetPredicate(
              (widget) => widget is FormTextField && widget.text == 'price'),
          '9.99');
      await tester.enterText(
          find.byWidgetPredicate((widget) =>
              widget is FormTextField && widget.text == 'description'),
          'This is a test product.');

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('9.99'), findsOneWidget);
      expect(find.text('This is a test product.'), findsOneWidget);
    });

    testWidgets('ADD and CANCEL buttons respond to taps', (tester) async {
      await pumpAddPage(tester);

      // Tap ADD button
      await tester.tap(find.text('ADD'));
      await tester.pump();

      // Here you can add expectations or verifications for what should happen when ADD is tapped

      // Tap CANCEL button
      await tester.tap(find.text('CANCEL'));
      await tester.pump();

      // Here you can add expectations or verifications for what should happen when CANCEL is tapped
    });
  });
}
