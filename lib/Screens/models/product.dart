import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final int quantity;
  final String description;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrls,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      price: data['price'] ?? 0.0,
      quantity: data['quantity'] ?? 0,
      description: data['description'] ?? '',
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
    );
  }
}
