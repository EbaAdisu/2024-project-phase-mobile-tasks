import 'package:ecommerce_mobile_app/model/product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  Function? removeProduct;
  Function? updateProduct;
  ProductCard(
      {super.key,
      required this.product,
      this.removeProduct,
      this.updateProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result =
            await Navigator.pushNamed(context, '/detail', arguments: product);
        if (result == 'DELETE') {
          removeProduct!(product);
        } else if (result is Product) {
          debugPrint('Product: card $result');
          updateProduct!(product, result);
        }
      },
      child: Card(
          elevation: 0,
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25), // Set the amount of the radius
          ),
          child: Column(
            // make the card fit the content
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3,
                child: Image.asset(
                  'images/shoe.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                // padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                padding: const EdgeInsets.fromLTRB(36, 12, 36, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product?.name} Shoes',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              '\$${product?.price}',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${product?.category}\'s Shoes',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow[600],
                                ),
                                Text('(${product?.rate})',
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
