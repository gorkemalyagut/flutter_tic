import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        backgroundColor: Colors.indigo.shade400,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Colors.indigo),
          ),
          SizedBox(height: 50,),
          Linkify(
            text: "Visit Press Page https://www.gigabyteltd.com/",
            options: LinkifyOptions(humanize: false),
          ),
            SizedBox(height: 50,),
          Linkify(
            text: "Service Press Page https://servis.gigabyteltd.com/",
            options: LinkifyOptions(humanize: false),
          ),
          SizedBox(height: 50,),
          Text("Phone Number: +90 392 444 22 98"),
          SizedBox(height: 50,),
          Text("Address: Fener Sk No:2, Lefkoşa 99010"),
      
        
          
        ],
        
        ),
      ),
  );
}
