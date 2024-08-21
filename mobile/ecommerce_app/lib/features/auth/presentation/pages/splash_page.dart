import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 5), () {
    //   Navigator.pushNamed(
    //     context,
    //     '/sign_in',
    //   );
    // });

    return const _SplashPage();
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/sign_in',
        );
      },
      child: Stack(
        children: [
          Image.asset(
            'images/background_image.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.blue.withOpacity(0.7), // adjust opacity as needed
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Column(
              // Center the children
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Image.asset(
                  'images/logo1.jpg',
                  width: 300,
                  height: 200,
                ),
                const Text(
                  'ECOMMERCE APP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.6,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
