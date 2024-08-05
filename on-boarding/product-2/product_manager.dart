// import Product class from product.dart file
import 'product.dart';

class ProductManager {
  // create a private variable to store products
  Map<String, Product> _products = {};

  // add a getter for length of products
  int get productsLength => _products.length;

  // add a method to add a product
  void addProduct(Product product) {
    if (_products.containsKey(product.productName)) {
      print('Product already exists');
    } else {
      _products[product.productName] = product;
    }
  }

  void viewAllProducts() {
    _products.forEach((key, value) {
      print("");
      print("Product Name: ${value.productName}");
      print("Product Price: ${value.productPrice}");
      print("Product Description: ${value.productDescription}");
      print("");
    });
  }

  void viewSingleProduct(String name) {
    if (_products.containsKey(name)) {
      print("");
      print("Product Name: ${_products[name]?.productName}");
      print("Product Price: ${_products[name]?.productPrice}");
      print("Product Description: ${_products[name]?.productDescription}");
      print("");
    } else {
      print("Product not found");
    }
  }

  Product getProduct(String name) {
    if (_products.containsKey(name)) {
      return _products[name]!;
    } else {
      print("Product not found");
      return Product("Product not found", 0, "Product not found");
    }
  }

  void editProduct(String name, double price, String description) {
    if (_products.containsKey(name)) {
      _products[name]?.productPrice = price;
      _products[name]?.productDescription = description;
    } else {
      print("Product not found");
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product.productName)) {
      _products.remove(product.productName);
    } else {
      print("Product not found");
    }
  }
}
