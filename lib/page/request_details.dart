import 'package:flutter/material.dart';
import 'package:flutter_tic/models/request_db.dart';
import 'package:flutter_tic/screen/login/components/profil_form.dart';


class RequestDetail extends StatefulWidget {
  RequestDetail({Key? key}) : super(key: key);


  @override
  _RequestDetailState createState()  => _RequestDetailState();
    
  
}

class _RequestDetailState extends State<RequestDetail> {
  
  RequestHelper helper = RequestHelper();


  bool shouldPop = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController= TextEditingController();


  @override
  Widget build(BuildContext context) {

    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    return  Scaffold(
         appBar: AppBar(
           title: Text("Edit"),
          backgroundColor: Colors.indigo.shade400,
          centerTitle: true,
           leading: IconButton(
             icon: Icon(Icons.close,size: 30,),
             onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPage()));
             
             },
             ),
         ),
         body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Title Text Field");
                    },
                    decoration: InputDecoration(
                      labelText: "Fullname",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("Something changed in Description Text Field");
                    },
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(fontSize: 15),
                              primary: Colors.indigoAccent,
                              shadowColor: Colors.indigoAccent,
                              elevation: 10,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15),
                              )
                            ),
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
  
                            },
                          ),
							          ),
                        Container(width: 5,),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(fontSize: 15),
                              primary: Colors.indigoAccent,
                              shadowColor: Colors.indigoAccent,
                              elevation: 10,
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(15),
                              )
                            ),
                            child: Text("Delete",textScaleFactor: 1.5,),
                            onPressed: () {

                              },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ),
      );
  }
}