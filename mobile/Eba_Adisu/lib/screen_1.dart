import 'package:counter/product_card.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  ScreenOne({super.key});
  List<Widget> _buildGridCards(int count) =>
      List.generate(count, (index) => const ProductCard());

  List<Card> _buildGridCards1(int count) {
    List<Card> cards = List.generate(
      count,
      (int index) => Card(
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
              aspectRatio: 3.4,
              child: Image.asset(
                'images/bugatti.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Derby Leather Shoes',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$120',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Men\'s shoe',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          )),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                          ),
                          const Text('(4.0)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
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
              ..._buildGridCards(3),
            ],
          ),
        ),
      ),
    );
  }
}
