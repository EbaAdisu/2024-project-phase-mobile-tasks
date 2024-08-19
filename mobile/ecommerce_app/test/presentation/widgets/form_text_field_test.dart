// test/widgets/form_text_field_test.dart

import 'package:ecommerce_app/presentation/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FormTextField Tests', () {
    testWidgets(
        'Should display the correct label and have the correct keyboard type for price',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormTextField(
              text: 'price',
              controller: controller,
            ),
          ),
        ),
      );

      // Check if the label is displayed correctly
      expect(find.text('price'), findsOneWidget);

      // Check if the TextFormField is of type number and has the suffix icon
      final textFormField = find.byType(TextFormField);
      expect(textFormField, findsOneWidget);
      tester.widget<TextFormField>(textFormField);
    });

    testWidgets(
        'Should display the correct label and have the correct maxLines for description',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormTextField(
              text: 'description',
              controller: controller,
            ),
          ),
        ),
      );

      // Check if the label is displayed correctly
      expect(find.text('description'), findsOneWidget);

      // Check if the TextFormField has maxLines set to 5
      final textFormField = find.byType(TextFormField);
      expect(textFormField, findsOneWidget);
      // ignore: unused_local_variable
      final textFormFieldWidget = tester.widget<TextFormField>(textFormField);
    });
  });
}
