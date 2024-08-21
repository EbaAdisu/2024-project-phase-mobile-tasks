import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../widgets/form_button.dart';
import '../widgets/form_text_field.dart';

class AddPage extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final ValueNotifier<String?> _imageUrlNotifier = ValueNotifier<String?>(null);

  AddPage({super.key});

  Future<void> _pickAndSaveImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final localImage = File('${directory.path}/$fileName');
      await File(pickedFile.path).copy(localImage.path);

      // Update the ValueNotifier with the new image URL
      _imageUrlNotifier.value = localImage.path;
      imageUrlController.text = localImage.path;
    }
  }

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
                GestureDetector(
                  onTap: () async {
                    await _pickAndSaveImage();
                  },
                  child: ValueListenableBuilder<String?>(
                    valueListenable: _imageUrlNotifier,
                    builder: (context, imageUrl, _) {
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F3),
                          borderRadius: BorderRadius.circular(20.0),
                          image: imageUrl != null
                              ? DecorationImage(
                                  image: FileImage(File(imageUrl)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imageUrl == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_outlined,
                                      size: 50,
                                      color: Colors.grey.shade700,
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Upload Image',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
                FormTextField(text: 'name', controller: nameController),
                FormTextField(text: 'price', controller: priceController),
                FormTextField(
                    text: 'description', controller: descriptionController),
                FormButton(
                  text: 'ADD',
                  nameController: nameController,
                  priceController: (priceController),
                  descriptionController: descriptionController,
                  imageUrlController: imageUrlController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 20),
                const FormButton(
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
