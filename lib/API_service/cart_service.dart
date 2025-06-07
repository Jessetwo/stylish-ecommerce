// services/cart_service.dart
import 'package:stylish/Models/product_model.dart';

class CartService {
  static final List<Product> _cartItems = [];

  static List<Product> get cartItems => _cartItems;

  static void addToCart(Product product) {
    _cartItems.add(product);
  }

  static void removeFromCart(Product product) {
    _cartItems.remove(product);
  }

  static void clearCart() {
    _cartItems.clear();
  }
}
