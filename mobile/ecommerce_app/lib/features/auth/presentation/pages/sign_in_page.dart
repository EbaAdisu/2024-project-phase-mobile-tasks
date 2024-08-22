import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../widgets/auth_form_button.dart';
import '../widgets/auth_form_text_field.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // get width of  the screen
  // double width = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        debugPrint('auth bloc state: $state');
        if (state is AuthSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Login Successful'),
            ));
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/home',
              (route) => false,
            );
          });
        } else if (state is AuthError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Authentication Failed: ${state.message}'),
              ),
            );
          });
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                          fit: BoxFit
                              .cover, // Make the image cover the entire box
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

                    AuthFormTextField(
                      text: 'Email',
                      controller: emailController,
                    ),
                    AuthFormTextField(
                      text: 'Password',
                      controller: passwordController,
                    ),
                    const SizedBox(height: 20),

                    // Add a button to navigate to the sign-up page
                    AuthFormButton(
                      text: 'Sign In',
                      formKey: _formKey,
                      emailController: emailController,
                      passwordController: passwordController,
                    ),
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
          ),
        );
      },
    );
  }
}
