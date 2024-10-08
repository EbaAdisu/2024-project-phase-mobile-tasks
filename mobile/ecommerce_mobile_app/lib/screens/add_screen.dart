import 'package:flutter/material.dart';

import '../widgets/form_button.dart';
import '../widgets/form_text_field.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    debugPrint('Product: add button touched');
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Product',
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
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius:
                        BorderRadius.circular(20.0), // Add border radius here
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 50,
                          color: Colors.grey.shade700,
                        ),
                        const SizedBox(height: 10),
                        Text('upload image',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                  ),
                ),
                FormTextField(text: 'name', controller: nameController),
                FormTextField(text: 'category', controller: categoryController),
                FormTextField(text: 'price', controller: priceController),
                FormTextField(
                    text: 'description', controller: descriptionController),
                FormButton(
                  text: 'ADD',
                  nameController: nameController,
                  priceController: (priceController),
                  descriptionController: descriptionController,
                  categoryController: categoryController,
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
