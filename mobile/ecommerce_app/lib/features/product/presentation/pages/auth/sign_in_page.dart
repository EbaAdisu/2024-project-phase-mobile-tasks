import 'package:flutter/material.dart';

import '../../widgets/form_button.dart';
import '../../widgets/form_text_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // get width of  the screen
  // double width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Sign In'),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(width * 0.12),
          child: Column(
            children: [
              SizedBox(
                width: width * 0.3,
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(0),
                  child: Image.asset(
                    'images/logo2.jpg',
                    fit: BoxFit.cover, // Make the image cover the entire box
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),

              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign into your account',
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
                text: 'Email',
                controller: emailController,
              ),
              FormTextField(
                text: 'Password',
                controller: passwordController,
              ),
              const SizedBox(height: 20),

              // Add a button to navigate to the sign-up page
              const FormButton(text: 'Sign In'),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // remove the space between the children
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Don't have an account?",
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
                      'SIGN UP',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () {
                      // Navigate to the sign-up page
                      Navigator.pushNamed(
                        context,
                        '/sign_up',
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
