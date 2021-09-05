import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tic/models/server.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final _formKey = GlobalKey<FormState>();
  late final serverProvider = Provider.of<Server>(context, listen: false);

  void _submitLink() {

    if (!_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        backgroundColor: Colors.indigo.shade400,
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.insert_link_outlined, color: Colors.indigo,size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Server Link",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Server Link",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
              validator: (input) => 
                  input!.trim().isEmpty ? 'Please enter your server Link' : null,
              initialValue: serverProvider.serverLink,
                onSaved: (input) {
                  setState(() {
                    serverProvider.setServerLink(input as String);
                });
                }
            ),
            SizedBox(height: 60),
            Align(
              alignment: Alignment.bottomCenter,
              child:ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.indigoAccent,
                shadowColor: Colors.indigoAccent,
                elevation: 10,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _submitLink,
              child: Text(
                "Save",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
  );

}