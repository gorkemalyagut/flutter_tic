import 'package:flutter/material.dart';
import 'package:flutter_tic/models/request.dart';
import 'package:flutter_tic/models/request_db.dart';

class AddRequest extends StatefulWidget {
  AddRequest({Key? key}) : super(key: key);

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {

  late RequestHelper db;
  late  String name,phone,type,description; 
  late int level;

  @override
  void initState() {
    super.initState();
    this.db = RequestHelper();
    this.db.initializeDB().whenComplete(() async {
      await this.addRequest();
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add Request'),
        backgroundColor: Colors.indigo.shade400,
        centerTitle: true,
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.attachment_outlined,size: 30,),
            onPressed: () {
            },
          ),

        ],
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              onSaved: (value) => level = value as int,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.format_list_numbered_rounded, color: Colors.indigo,size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Level",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Level",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
        ),
        SizedBox(height: 25),
        TextFormField(
          onSaved: (value) => name = value!,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.perm_identity, color: Colors.indigo, size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Full Name",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Full Name",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
        ),
        SizedBox(height: 25),
        TextFormField(
          onSaved: (value) => phone = value!,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.local_phone, color: Colors.indigo, size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Phone",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Phone",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
        ),
        SizedBox(height: 25),
        TextFormField(
          onSaved: (value) => type = value!,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.text_snippet_outlined, color: Colors.indigo, size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Type",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Type",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
        ),
                SizedBox(height: 25),
        TextFormField(
          onSaved: (value) => description = value!,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                icon: Icon(Icons.description_outlined, color: Colors.indigo, size: 30,),
                hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                hintText: "Description",
                labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                labelText: "Description",
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.indigo,
                  ),
                ),
              ),
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
          onPressed: () {
           
          },
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
  Future<int> addRequest() async {
    RequestsDB firstrequest = RequestsDB(fullname: 'test', description: 'test3', phone: '65454654',level: 1,type: 'test');
    RequestsDB secondrequest = RequestsDB(fullname: 'gorkem', description: 'Test1', phone: '5338214139',level: 2,type: 'test');
    RequestsDB thirdrequest = RequestsDB(fullname: 'test', description: 'Test2', phone: '5338214139',level: 3,type: 'test');
    List<RequestsDB> listOfRequests = [firstrequest,secondrequest,thirdrequest];
    return await this.db.insertRequest(listOfRequests);
  }
}