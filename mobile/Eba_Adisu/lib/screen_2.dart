import 'package:flutter/material.dart';

class ScreenTwo extends StatelessWidget {
  ScreenTwo({super.key});
  final prices = ['39', '40', '41', '42', '43', '44'];

  final String text =
      "A derby leather shoe is classix and versatile footwear option charachterized by its open lacing system where the shoelace eyelats are sewn on top of the vamp(the upperpart of the shoe). th" *
          6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('images/shoe.jpg'),
                Positioned(
                  top: 40,
                  left: 30,
                  child: Container(
                    width: 40, // Set the width
                    height: 40, // Set the height
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: AspectRatio(
                      aspectRatio: 1,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.blue,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
              child: Column(
                children: [
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Derby Leather',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '\$120',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Size:',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75, // Adjust this value as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: prices.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: index == 2 ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade500
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 0.0, // Shadow spread radius
                                blurRadius: 1, // Shadow blur radius
                                offset: const Offset(0, 1), // Shadow position
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              prices[index],
                              style: TextStyle(
                                color: index == 2 ? Colors.white : Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        padding: EdgeInsets.all(20),
        height: 100,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ActionButton(action: 'DELETE'),
            ActionButton(action: 'UPDATE'),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.action,
  });
  final String? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle delete
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
