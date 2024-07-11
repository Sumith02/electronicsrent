// screens/cart_screen.dart
import 'package:electronicsrent/Screens/models/cart_item.dart';
import 'package:electronicsrent/Screens/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  static const String id = 'cart-screen';

  @override
  Widget build(BuildContext context) {
    final cartService = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: cartService.items.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartService.items.length,
              itemBuilder: (context, index) {
                CartItem cartItem = cartService.items[index];
                return ListTile(
                  leading: Image.network(cartItem.product.imageUrl),
                  title: Text(cartItem.product.name),
                  subtitle: Text('Quantity: ${cartItem.quantity}'),
                  trailing: Text('\$${(cartItem.product.price * cartItem.quantity).toStringAsFixed(2)}'),
                  onLongPress: () {
                    cartService.removeItem(cartItem);
                  },
                );
              },
            ),
    );
  }
}
