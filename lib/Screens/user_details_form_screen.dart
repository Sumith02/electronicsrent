import 'package:electronicsrent/Screens/services/database_service.dart';
import 'package:flutter/material.dart';
//import '../services/database_service.dart';

class UserDetailsFormScreen extends StatefulWidget {
  final String productId;
  UserDetailsFormScreen({required this.productId});

  static const String id = 'user_details_form_screen';

  @override
  _UserDetailsFormScreenState createState() => _UserDetailsFormScreenState();
}

class _UserDetailsFormScreenState extends State<UserDetailsFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';

  Future<void> _submitUserDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await DatabaseService().addUserDetails({
        'name': _name,
        'email': _email,
        'phone': _phone,
        'productId': widget.productId,
      });

      // Show confirmation dialog with product details
      showDialog(
        context: context,
        builder: (context) {
          return FutureBuilder(
            future: DatabaseService().getProduct(widget.productId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return Center(child: Text('Error fetching product details.'));
              }
              var product = snapshot.data;
              return AlertDialog(
                title: Text('Confirm Product Submission'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(product?['imageUrls'][0]),
                    Text('Product Name: ${product?['name']}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product submitted successfully!')));
                    },
                    child: Text('Confirm'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Your Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitUserDetails,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
