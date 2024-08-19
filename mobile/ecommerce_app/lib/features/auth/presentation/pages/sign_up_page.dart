import 'package:flutter/material.dart';

import '../../../product/presentation/widgets/form_button.dart';
import '../../../product/presentation/widgets/form_text_field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final ValueNotifier<bool> _checkboxValueNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Image.asset(
            'images/logo2.jpg',
            width: width * 0.15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.12),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Create your account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.6,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FormTextField(
                text: 'Name',
                controller: nameController,
              ),
              FormTextField(
                text: 'Email',
                controller: emailController,
              ),
              FormTextField(
                text: 'Password',
                controller: passwordController,
              ),
              FormTextField(
                text: 'Confirm Password',
                controller: confirmPasswordController,
              ),
              const SizedBox(height: 20),
              // argiment to understand the terms and conditions
              Row(
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _checkboxValueNotifier,
                    builder: (context, value, child) {
                      return Checkbox(
                        value: value,
                        // make the checkbox color blue
                        activeColor: Colors.blue,
                        onChanged: (bool? newValue) {
                          _checkboxValueNotifier.value = newValue ?? false;
                        },
                      );
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'I understood the ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              decoration: TextDecoration.none,
                            )),
                        TextSpan(
                          text: 'terms & policy',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const FormButton(text: 'Sign up'),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // remove the space between the children
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Have an account?',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w500,
                        // add spacing
                        letterSpacing: 1.3,
                      )),
                  TextButton(
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the sign-up page
                      Navigator.pushNamed(
                        context,
                        '/sign_in',
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
