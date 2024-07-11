import 'package:electronicsrent/Screens/models/product.dart';
import 'package:electronicsrent/Screens/services/database_service.dart';
import 'package:electronicsrent/Screens/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/widget/banner_widget.dart';
import '../components/widget/category_widget.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _dbService = DatabaseService();
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    List<Product> products = await _dbService.getProducts();
    setState(() {
      _products = products;
    });
  }

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  @override
Widget build(BuildContext context) {
  final locationService = LocationService();
  final locationData = locationService.locationData;
  final address = locationService.address;

  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(address ?? 'No address found'),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
      ],
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 10),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: 'Find your item',
                        labelStyle: TextStyle(fontSize: 12),
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.notifications_none),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 6, 12, 8),
              child: Column(
                children: [
                  SlidingBannerWidget(),
                  CategoryWidget(),
                  if (_products.isEmpty)
                    Center(child: CircularProgressIndicator())
                  else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height *
                            0.5, // Adjust height as needed
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3 / 4,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            Product product = _products[index];
                            return Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      product.imageUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Colors.grey),
                                        ),
                                        SizedBox(height: 4),
                                        ElevatedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${product.name} added to cart'),
                                              ),
                                            );
                                          },
                                          child: Text('Add to Cart'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

}
