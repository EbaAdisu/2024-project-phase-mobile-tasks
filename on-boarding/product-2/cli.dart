import 'dart:io';
import './product.dart';
import './product_manager.dart';

void main(List<String> args) {
  print("");
  print("Welcome to the Product Manager CLI");
  print("");

  ProductManager productManager = ProductManager();
  while (true) {
    print(
        "Enter a command from list of [add, view, view-single, edit, remove, exit]: ");
    String? command = stdin.readLineSync();
    if (command == "add") {
      print("Enter product name: ");
      String? name = stdin.readLineSync();
      print("Enter product price: ");
      double? price = double.tryParse(stdin.readLineSync()!);
      print("Enter product description: ");
      String? description = stdin.readLineSync();
      Product product = Product(name!, price!, description!);
      productManager.addProduct(product);
    } else if (command == "view") {
      productManager.viewAllProducts();
    } else if (command == "view-single") {
      print("Enter product name: ");
      String? name = stdin.readLineSync();
      productManager.viewSingleProduct(name!);
    } else if (command == "edit") {
      print("Enter product name: ");
      String? name = stdin.readLineSync();
      print("Enter new price: ");
      double? price = double.tryParse(stdin.readLineSync()!);
      print("Enter new description: ");
      String? description = stdin.readLineSync();
      productManager.editProduct(name!, price!, description!);
    } else if (command == "remove") {
      print("Enter product name: ");
      String? name = stdin.readLineSync();
      Product product = productManager.getProduct(name!);
      productManager.removeProduct(product);
    } else if (command == "exit") {
      break;
    } else {
      print("Invalid command");
    }
    print("");
  }
}
