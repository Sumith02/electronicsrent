import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addProduct(Map<String, dynamic> productData) async {
    DocumentReference docRef = await _db.collection('products').add(productData);
    return docRef.id;
  }

  Future<void> addUserDetails(Map<String, dynamic> userDetails) async {
    await _db.collection('user_details').add(userDetails);
  }

  Future<Map<String, dynamic>> getProduct(String productId) async {
    DocumentSnapshot doc = await _db.collection('products').doc(productId).get();
    return doc.data() as Map<String, dynamic>;
  }
}
