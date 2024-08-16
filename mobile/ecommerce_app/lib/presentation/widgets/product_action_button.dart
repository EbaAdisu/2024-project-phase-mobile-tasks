import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';

class ProductActionButton extends StatelessWidget {
  final ProductModel? product;
  const ProductActionButton({
    super.key,
    this.action,
    this.product,
  });
  final String? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (action == 'DELETE') {
          debugPrint('Product: Delete button touched $product');
          // bloc delete logic here
          BlocProvider.of<ProductBloc>(context)
              .add(DeleteProductEvent(product!.id));

          BlocProvider.of<ProductBloc>(context).stream.listen((state) {
            if (state is InitialState) {
              debugPrint('Product: delete success');
              BlocProvider.of<ProductBloc>(context)
                  .add(const LoadAllProductEvent());
              Navigator.pop(context);
            } else {
              debugPrint('Error: $state');
            }
          });
        } else {
          Navigator.pushNamed(context, '/update', arguments: product);
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
