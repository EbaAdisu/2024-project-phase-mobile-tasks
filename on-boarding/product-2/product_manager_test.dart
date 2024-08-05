import 'package:test/test.dart';
import 'product_manager.dart';
import 'product.dart';

void main() {
  group('ProductManager', () {
    test('should add a product', () {
      final productManager = ProductManager();
      final product = Product('Test Product', 10, 'This is a test product');

      productManager.addProduct(product);

      expect(productManager.productsLength, 1);
    });

    test('should edit a product', () {
      final productManager = ProductManager();
      final product = Product('Test Product', 10.0, 'This is a test product');
      productManager.addProduct(product);

      productManager.editProduct(
          'Test Product', 20.0, 'This is an updated test product');

      final updatedProduct = productManager.getProduct('Test Product');
      expect(updatedProduct.productPrice, 20.0);
      expect(
          updatedProduct.productDescription, 'This is an updated test product');
    });
    test('should remove a product', () {
      final productManager = ProductManager();
      final product = Product('Test Product', 10.0, 'This is a test product');
      productManager.addProduct(product);

      productManager.removeProduct(product);

      expect(productManager.productsLength, 0);
    });
  });
}
