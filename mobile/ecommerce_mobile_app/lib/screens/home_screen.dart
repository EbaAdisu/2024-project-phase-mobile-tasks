import 'package:ecommerce_mobile_app/model/product.dart';
import 'package:ecommerce_mobile_app/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen> {
  final List<Product> products = [];
  void removeProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }

  void updateProduct(Product oldProduct, Product newProduct) {
    setState(() {
      if (newProduct.name != '') {
        oldProduct.name = newProduct.name;
      }
      if (newProduct.price != 0) {
        oldProduct.price = newProduct.price;
      }
      if (newProduct.description != '') {
        oldProduct.description = newProduct.description;
      }
      if (newProduct.category != '') {
        oldProduct.category = newProduct.category;
      }

      // products.remove(product);
    });
  }

  List<Widget> _buildGridCards() => products
      .map((product) => ProductCard(
            product: product,
            removeProduct: removeProduct,
            updateProduct: updateProduct,
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          debugPrint('Product: add button touched');
          final result = await Navigator.pushNamed(context, '/add');
          if (result is Product) {
            setState(() {
              products.add(result);
            });
          }
        },
        backgroundColor: Colors.blue, // Set the background color to blue
        child: const Icon(
          Icons.add, // Use the add icon
          color: Colors.white,
          size: 50, // Set the icon color to white
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              ListTile(
                // make the leading square avatar
                leading: Container(
                  // color: Colors.black,
                  width: 50.0, // Set the width of the square avatar
                  height: 50.0, // Set the height of the square avatar
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the amount of the radius

                    // shape: BoxShape.rectangle, // Set the shape to rectangle
                    image: const DecorationImage(
                      image: AssetImage(
                          'images/joker.jpg'), // Provide the path to your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text('July 14 2023',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    )),
                subtitle: Text.rich(
                  TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ), // Default style for the text
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Yohannes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ), // Bold style for "Yohannes"
                      ),
                    ],
                  ),
                ),
                trailing: Container(
                  height: 50,
                  width: 50,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(
                            color:
                                Colors.grey.shade500), // Set the outline color
                      ),
                      icon: Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.grey.shade800,
                        size: 30, // Set the icon color
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text('Available Products',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                trailing: Container(
                  height: 50,
                  width: 50,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: IconButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(
                            color:
                                Colors.grey.shade300), // Set the outline color
                      ),
                      icon: Center(
                        child: Icon(
                          Icons.search,
                          color: Colors.grey.shade400,
                          size: 30, // Set the icon color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ..._buildGridCards(),
            ],
          ),
        ),
      ),
    );
  }
}
