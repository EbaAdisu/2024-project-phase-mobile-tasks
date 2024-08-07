import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                            'Derby Leather Shoes',
                            style: TextStyle(
                              color: Colors.grey.shade800,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '\$120',
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
                            'Men\'s shoe',
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
                              Text('(4.0)',
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
        ));
  }
}
