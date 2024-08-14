import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Page'),
      ),
      body: const Center(
        child: Text('Product Page'),
      ),
    );
  }
}
