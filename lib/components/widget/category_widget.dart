import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronicsrent/Screens/firebase_services.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseServices _service = FirebaseServices();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: _service.categories.get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container(
                height: 200,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Error loading categories'),
                        Text('See all')
                      ],
                    ),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Container(
              height: 100,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Categories')),
                      TextButton(
                        onPressed: () {},
                        child: Text('see all'),
                      ),
                    ],
                  ),
                  // You can add more widgets to display the categories here
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
  