import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductActionButton extends StatelessWidget {
  Product? product;
  ProductActionButton({
    super.key,
    this.action,
    this.product,
  });
  final String? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (action == 'DELETE') {
          Navigator.pop(context, 'DELETE');
        } else {
          final result = await Navigator.pushNamed(context, '/update');
          if (result is Product) {
            debugPrint('Product: detail $result');
            Navigator.pop(context, result);
          }
        }
      },
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: action == 'DELETE' ? Colors.red : Colors.blue,
          width: 2,
        ),
        backgroundColor: action == 'DELETE' ? Colors.white : Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Text(
          '$action',
          style: TextStyle(
            color: action == 'DELETE' ? Colors.red : Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
