import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addItem(Product product) {
    for (CartItem item in _items) {
      if (item.product.id == product.id) {
        item.updateQuantity(item.quantity + 1);
        notifyListeners();
        return;
      }
    }
    _items.add(CartItem(product: product, quantity: 1));
    notifyListeners();
  }

  void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
