import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Emit the LoadAllProductsEvent when the widget is built

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.blue, // Set the background color to blue
        child: const Icon(
          Icons.add, // Use the add icon
          color: Colors.white,
          size: 50, // Set the icon color to white
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the AppBar background color
        elevation: 0, // Remove the shadow under the AppBar
        title: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Match ListTile padding
          child: Row(
            children: [
              Container(
                width: 50.0, // Set the width of the square avatar
                height: 50.0, // Set the height of the square avatar
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Set the radius
                  image: const DecorationImage(
                    image: AssetImage('images/joker.jpg'), // Path to your image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                  width: 10.0), // Add spacing between avatar and text
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'July 14 2023',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Yohannes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 16.0), // Match ListTile padding
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_active_outlined,
                color: Colors.grey.shade800,
                size: 30, // Set the icon size
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            ListTile(
              title: const Text('Available Products',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              trailing: SizedBox(
                height: 50,
                width: 50,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: IconButton(
                    onPressed: () {
                      BlocProvider.of<ProductBloc>(context)
                          .add(const LoadAllProductEvent());
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(
                          color: Colors.grey.shade300), // Set the outline color
                    ),
                    icon: Center(
                      child: Icon(
                        Icons.restart_alt_outlined,
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
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is LoadedAllProductState) {
                  return ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ProductCard(
                          product: ProductModel(
                            id: product.id,
                            name: product.name,
                            price: product.price,
                            imageUrl: product.imageUrl,
                            description: product.description,
                          ),
                        );
                      });
                } else {
                  return const Center(child: Text('No data found'));
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
