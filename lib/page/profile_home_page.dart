import 'package:flutter/material.dart';
import 'package:flutter_tic/screen/login/login.dart';

class ProfileHome extends StatelessWidget {
  const ProfileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.indigo.shade400,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined,size: 35,),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          ),
        ],
      ),
      body: Center(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.indigo.shade100,
            radius: 56,
            child: Icon(Icons.person, size: 50, color: Colors.indigo,),
          ),
          SizedBox(height: 40),
          buildName(),
        ],
      )
      )
      );
      Widget buildName() => Column(
        children: [
          Text(
            "Gigabyteltd",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          Text(
            "servis@gigabyteltd.com",
            style: TextStyle(color: Colors.blueGrey),
          )
        ],
      );
}