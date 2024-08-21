import 'package:flutter/material.dart';

class AuthFormButton extends StatelessWidget {
  final TextEditingController? nameController; // = TextEditingController();
  final TextEditingController? priceController;
  final TextEditingController? descriptionController;
  final TextEditingController? imageUrlController;
  final dynamic formKey;
  const AuthFormButton({
    super.key,
    required this.text,
    this.nameController,
    this.priceController,
    this.descriptionController,
    this.imageUrlController,
    this.formKey,
  });
  final String text;
  double tryParse(String text) {
    double result;
    try {
      result = double.parse(text);
    } catch (e) {
      // handle the exception, e.g., show an error message
      debugPrint('Invalid double: $text');
      result = 1.0; // or any default value
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: Colors.blue.shade700, width: 2),
          backgroundColor: Colors.blue.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
