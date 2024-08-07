import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          // key: _formKey,
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
                const FormField(text: 'name'),
                const FormField(text: 'category'),
                const FormField(text: 'price'),
                const FormField(text: 'description'),
                const FormButton(
                  text: 'ADD',
                ),
                const SizedBox(height: 20),
                const FormButton(
                  text: 'DELETE',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle update
        },
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color: text == 'ADD' ? Colors.blue : Colors.red, width: 2),
          backgroundColor: text == 'ADD' ? Colors.blue : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Text(
            text,
            style: TextStyle(
              color: text == 'ADD' ? Colors.white : Colors.red,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({
    super.key,
    required this.text,
  });

  final String text;
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
