// import 'dart:math';

class Product {
  String _name;
  double _price;
  String _description;

  Product(this._name, this._price, this._description);

  // Getters for Product

  // add get method to get the product name
  String get productName => _name;

  // add get method to get the product price
  double get productPrice => _price;

  // add get method to get the product description
  String get productDescription => _description;

  // Setters for Product

  // add set method to set the product price
  set productPrice(double price) => _price = price;

  // add set method to set the product description
  set productDescription(String description) => _description = description;
}
