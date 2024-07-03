import 'package:electronicsrent/Screens/services/location_services.dart';
import 'package:electronicsrent/components/widget/banner_widget.dart';
import 'package:electronicsrent/components/widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';


class HomeScreen extends StatelessWidget {
  static const String id = 'home-screen';

  HomeScreen();

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
                          prefixIcon: Icon(
                            Icons.search,
                          ),
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
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.notifications_none),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 6, 12, 8),
            child: Column(
              children: [
                SlidingBannerWidget(),
                CategoryWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
