import 'package:flutter/material.dart';

import '../model/product.dart';

class FormButton extends StatelessWidget {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? categoryController = TextEditingController();
  TextEditingController? priceController = TextEditingController();
  TextEditingController? descriptionController;
  TextEditingController? typeController;
  final formKey;
  FormButton({
    super.key,
    required this.text,
    this.nameController,
    this.priceController,
    this.descriptionController,
    this.categoryController,
    this.typeController,
    this.formKey,
  });
  final String text;
  double tryParse(String text) {
    double result;
    try {
      result = double.parse(text);
    } catch (e) {
      // handle the exception, e.g., show an error message
      print('Invalid double: $text');
      result = 0.0; // or any default value
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (text == 'ADD') {
            if (formKey.currentState!.validate()) {
              debugPrint('Product: add button touched');
              // Add product to home screen
              Navigator.pop(
                  context,
                  Product(
                    name: nameController!.text,
                    price: tryParse(priceController!.text),
                    description: descriptionController!.text,
                    category: categoryController!.text,
                    rate: 0,
                  ));
            }
          } else if (text == 'UPDATE') {
            Navigator.pop(
                context,
                Product(
                  name: nameController!.text,
                  price: tryParse(priceController!.text),
                  description: descriptionController!.text,
                  category: categoryController!.text,
                  rate: 0,
                ));

            // return product to home screen
          } else {
            Navigator.pop(context, 'CANCEL');
          }
          // Handle update
        },
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color: text == 'CANCEL' ? Colors.red : Colors.blue, width: 2),
          backgroundColor: text == 'CANCEL' ? Colors.white : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(
            text,
            style: TextStyle(
              color: text == 'CANCEL' ? Colors.red : Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
