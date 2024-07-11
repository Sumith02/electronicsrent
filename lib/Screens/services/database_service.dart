import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    QuerySnapshot snapshot = await _db.collection('electronics_items').get();
    return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
  }

  Future<String> addProduct(Map<String, dynamic> productData) async {
    DocumentReference docRef = await _db.collection('electronics_items').add(productData);
    return docRef.id;
  }

  Future<void> addUserDetails(Map<String, dynamic> userDetails) async {
    await _db.collection('users').add(userDetails);
  }

  Future<Map<String, dynamic>> getProduct(String productId) async {
    DocumentSnapshot doc = await _db.collection('electronics_items').doc(productId).get();
    return doc.data() as Map<String, dynamic>;
  }
}
