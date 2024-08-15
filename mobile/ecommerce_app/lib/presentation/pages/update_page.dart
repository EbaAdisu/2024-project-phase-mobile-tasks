import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import '../widgets/form_button.dart';
import '../widgets/form_text_field.dart';

class UpdatePage extends StatelessWidget {
  UpdatePage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as ProductModel;
    debugPrint('Product: Update button touched');
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Update Product',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  product.imageUrl,
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                FormTextField(text: 'name', controller: nameController),
                FormTextField(text: 'price', controller: priceController),
                FormTextField(
                    text: 'description', controller: descriptionController),
                FormButton(
                  text: 'UPDATE',
                  nameController: nameController,
                  priceController: priceController,
                  descriptionController: descriptionController,
                  product: product,
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),
                FormButton(
                  text: 'CANCEL',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
