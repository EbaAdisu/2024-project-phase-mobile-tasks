import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class FormButton extends StatelessWidget {
  TextEditingController? nameController; // = TextEditingController();
  TextEditingController? priceController;
  TextEditingController? descriptionController;
  TextEditingController? imageUrlController;
  ProductModel? product;
  dynamic formKey;
  FormButton({
    super.key,
    required this.text,
    this.nameController,
    this.priceController,
    this.descriptionController,
    this.imageUrlController,
    this.formKey,
    this.product,
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
        onPressed: () {
          if (text == 'UPDATE') {
            // bloc update logic here
            final updatedProduct = ProductModel(
              id: product!.id,
              name: nameController!.text,
              description: descriptionController!.text,
              price: tryParse(priceController!.text),
              imageUrl: product!.imageUrl,
            );
            debugPrint('Product: Update button touched $updatedProduct');
            BlocProvider.of<ProductBloc>(context)
                .add(UpdateProductEvent(updatedProduct));

            BlocProvider.of<ProductBloc>(context).stream.listen((state) {
              if (state is LoadedSingleProductState) {
                debugPrint('Product: Update success');
                Navigator.pushNamed(context, '/');
              } else {
                debugPrint('Error: $state');
              }
            });
          } else if (text == 'ADD') {
            if (formKey.currentState!.validate() &&
                imageUrlController!.text.isNotEmpty) {
              debugPrint(
                  'Product: Add button touched ${imageUrlController!.text}');
              final newProduct = ProductModel(
                id: 'idIsNOtNeeded',
                name: nameController!.text,
                description: descriptionController!.text,
                price: tryParse(priceController!.text),
                imageUrl: imageUrlController!.text,
              );
              debugPrint('Product: Add button touched $newProduct');
              BlocProvider.of<ProductBloc>(context)
                  .add(CreateProductEvent(newProduct));

              BlocProvider.of<ProductBloc>(context).stream.listen((state) {
                if (state is LoadedSingleProductState) {
                  debugPrint('Product: Add success');
                  Navigator.pushNamed(context, '/');
                } else {
                  debugPrint('Error: $state');
                }
              });
            }
          } else {
            Navigator.pop(context);
          }
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
