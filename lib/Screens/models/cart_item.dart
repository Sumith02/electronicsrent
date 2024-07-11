import 'package:electronicsrent/Screens/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
  }
}
