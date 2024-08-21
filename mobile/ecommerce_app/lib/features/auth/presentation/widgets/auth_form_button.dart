import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/entities/register_entity.dart';
import '../bloc/auth_bloc.dart';

class AuthFormButton extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final TextEditingController? confirmPasswordController;
  final GlobalKey<FormState> formKey;
  const AuthFormButton({
    super.key,
    required this.text,
    this.nameController,
    this.emailController,
    this.passwordController,
    this.confirmPasswordController,
    required this.formKey,
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
          debugPrint('Button pressed $text');

          if (text == 'Sign Up') {
            debugPrint('Name: ${nameController!.text}');
            debugPrint('Email: ${emailController!.text}');
            debugPrint('Password: ${passwordController!.text}');
            debugPrint('Confirm Password: ${confirmPasswordController!.text}');
            if (formKey.currentState!.validate() &&
                passwordController!.text == confirmPasswordController!.text) {
              debugPrint('Name: ${nameController!.text}');
              debugPrint('Email: ${emailController!.text}');
              debugPrint('Password: ${passwordController!.text}');
              debugPrint(
                  'Confirm Password: ${confirmPasswordController!.text}');

              final registrationEntity = RegistrationEntity(
                name: nameController!.text,
                email: emailController!.text,
                password: passwordController!.text,
              );
              // emit RegisterEvent
              BlocProvider.of<AuthBloc>(context)
                  .add(RegisterEvent(registrationEntity: registrationEntity));

              // listen to the state
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  debugPrint('AuthBloc state: $state');
                  if (state is AuthRegisterSuccess) {
                    Navigator.pushNamed(context, '/sign_in');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
              );
            }
          } else if (text == 'Sign In') {
            if (formKey.currentState!.validate()) {
              debugPrint('Email: ${emailController!.text}');

              debugPrint('Password: ${passwordController!.text}');

              final loginEntity = LoginEntity(
                email: emailController!.text,
                password: passwordController!.text,
              );
              BlocProvider.of<AuthBloc>(context)
                  .add(LoginEvent(loginEntity: loginEntity));

              // listen to the state
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  debugPrint('AuthBloc state: $state');
                  if (state is AuthSuccess) {
                    Navigator.pushNamed(context, '/home');
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                      ),
                    );
                  }
                },
              );
            }
          }
        },
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
