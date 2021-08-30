import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic/page/add_request_page.dart';
import 'package:flutter_tic/page/contact_page.dart';
import 'package:flutter_tic/page/profile_home_page.dart';
import 'package:flutter_tic/page/requests_page.dart';
import 'package:flutter_tic/page/setting_page.dart';

class AppPage extends StatefulWidget {
  AppPage({Key? key}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int index =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: buildPages(),
       bottomNavigationBar: buildbottomNavigation(),
    );
  }
  Widget buildPages() {
    switch(index){
      case 1:
        return Request();
      case 2:
        return AddRequest();
      case 3:
        return Settings();
      case 4:
        return Contact();
      case 0:
      default:
        return ProfileHome();
    }
  }
  Widget  buildbottomNavigation() {
    return BottomNavyBar(
      itemCornerRadius: 32,
      backgroundColor: Colors.indigo.shade100,
      containerHeight: 80,
      selectedIndex: index,
      onItemSelected: (index) => setState(() => this.index = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.account_circle_outlined),
          title: Text('Profile'),
          activeColor: Colors.indigo.shade900,
          textAlign: TextAlign.center,
          inactiveColor: Colors.indigo.shade900,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.fact_check_outlined),
          title: Text('Requests'),
          activeColor: Colors.indigo.shade900,
          textAlign: TextAlign.center,
          inactiveColor: Colors.indigo.shade900,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.note_add_outlined ),
          title: Text('AddRequest'),
          activeColor: Colors.indigo.shade900,
          textAlign: TextAlign.center,
          inactiveColor: Colors.indigo.shade900,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Colors.indigo.shade900,
          textAlign: TextAlign.center,
          inactiveColor: Colors.indigo.shade900,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.contact_support_outlined),
          title: Text('Contact'),
          activeColor: Colors.indigo.shade900,
          textAlign: TextAlign.center,
          inactiveColor: Colors.indigo.shade900,
        ),
      ],
    ); 
  }
}