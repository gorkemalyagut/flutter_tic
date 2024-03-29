import 'package:flutter/material.dart';
import 'package:flutter_tic/models/server.dart';
import 'package:flutter_tic/screen/login/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() {
  
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Server(),),
    ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2661FA),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
      ),
      
      home: LoginScreen(),
    ),
    );
  }
}