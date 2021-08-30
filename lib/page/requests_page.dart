import 'package:flutter/material.dart';
import 'package:flutter_tic/models/request.dart';
import 'package:flutter_tic/models/request_db.dart';
import 'package:flutter_tic/page/add_request_page.dart';
import 'package:flutter_tic/page/request_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Request extends StatefulWidget {

  @override
  State <StatefulWidget> createState() {
    return RequestState();
  }
}
class RequestState extends State<Request> {

  int count = 0;
  late RequestHelper handler;
  late List<RequestsDB> requestList;

  @override
  void initState() {
    super.initState();
    this.handler = RequestHelper();
    this.handler.initializeDB().whenComplete(() async {
      
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {

    final DateTime now = DateTime.now();
    
    return Scaffold(
       appBar: AppBar(title: Text("Pandding Requests"),
       backgroundColor: Colors.indigo.shade400,
       centerTitle: true,
       ),
       body: FutureBuilder(
         future: this.handler.retrieveRequest(),
        builder: (BuildContext context, AsyncSnapshot<List<RequestsDB>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.delete_forever),
                  ),
                  key: ValueKey<int>(snapshot.data![index].level),
                  onDismissed: (DismissDirection direction) async {
                    await this.handler.deleteRequest(snapshot.data![index].level);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
                  },
                  child: Card(
                    
                      child: ListTile(
                    leading: Icon(Icons.fact_check_outlined),
                    contentPadding: EdgeInsets.all(8.0),
                    title: Text(snapshot.data![index].description,),
                    subtitle: Text(snapshot.data![index].fullname.toString(),),
                    trailing: Text('$now'),
                    isThreeLine: true,
                   
                    
                  )),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
       floatingActionButton: FloatingActionButton(
         onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RequestDetail()));
         },
         tooltip: "Add Details",
         child: Icon(Icons.add, size: 30, ),
         backgroundColor: Colors.indigo,
       ),
       
    );
  }
  void updateListView() {
		final Future<Database> dbFuture = handler.initializeDB();
		dbFuture.then((database) {

			Future<List<RequestsDB>> requestListFuture = handler.retrieveRequest();
			requestListFuture.then((requestList) {
				setState(() {
				  this.requestList = requestList;
				  this.count = requestList.length;
				});
			});
		});
  }
  void navigateToDetail(RequestsDB request, String name) async {
	  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
		  return AddRequest();
	  }));

	  if (result == true) {
	  	updateListView();
	  }
  }
 
}