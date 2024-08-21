import 'package:flutter/material.dart';

class AuthFormTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  const AuthFormTextField({
    super.key,
    required this.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              )),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? 'Please enter a $text' : null,
          keyboardType:
              text == 'price' ? TextInputType.number : TextInputType.text,
          maxLines: text == 'description'
              ? 5
              : 1, // Make the field longer for description
          decoration: InputDecoration(
            suffixIcon: text == 'price'
                ? const Icon(Icons.attach_money)
                : null, // Dollar icon
            fillColor: const Color(0xFFF3F3F3), // Make the input area gray
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
