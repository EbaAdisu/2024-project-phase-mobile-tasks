import 'package:counter/product_card.dart';
import 'package:flutter/material.dart';

class ScreenFour extends StatelessWidget {
  ScreenFour({super.key});
  final List<Widget> _productCards =
      List.generate(3, (index) => const ProductCard());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Search Product',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: screenWidth * 0.75,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        labelText: "Leather",
                        border: OutlineInputBorder(
                          // borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: screenWidth * 0.10,
                    width: screenWidth * 0.10,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blue, // Set the background color
                      borderRadius:
                          BorderRadius.circular(10.0), // Keep the curvish style
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: IconButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          side: BorderSide(
                              color: Colors
                                  .grey.shade300), // Set the outline color
                        ),
                        icon: const Center(
                          child: Icon(
                            Icons.filter_list,
                            color: Colors.white,
                            size: 30, // Set the icon color
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ..._productCards,
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Category',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  // borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Price',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            const SizedBox(height: 10),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10.0,
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0.0), // Adjust the thumb size
              ),
              child: RangeSlider(
                max: 10,
                min: 0,
                activeColor: Colors.blue,
                values: const RangeValues(2, 8),
                onChanged: (RangeValues range) {},
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle update
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue, width: 2),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(13),
                  child: Text(
                    'APPLY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
