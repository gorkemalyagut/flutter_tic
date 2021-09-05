import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic/models/request.dart';
import 'package:flutter_tic/models/request_db.dart';
import 'package:flutter_tic/page/add_request_page.dart';
import 'package:flutter_tic/screen/login/components/profil_form.dart';
import 'package:intl/intl.dart';

class Requests extends StatefulWidget {

  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {

  late Future<List<RequestsDB>> _requestList;

  final DateFormat _dateFormatter = DateFormat('MMM dd , yyyy');

  RequestHelper _dbHelper = RequestHelper.instance;

  @override
  void initState(){
    super.initState();
    _updateRequestsList();
  }

  _updateRequestsList(){
    _requestList = RequestHelper.instance.getRequestList();
  }

  Widget _buildRequests(RequestsDB request){
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          ListTile(
            title: Text('${request.type!} -- ${_dateFormatter.format(request.date!)}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              decoration: request.status == 0 
                ? TextDecoration.none 
                  : TextDecoration.lineThrough
            ),),
            subtitle: Text('${request.fullname} - ${request.priority} - Tekniker Atandı',style: TextStyle(
              fontSize: 18,
              color: Colors.indigo.shade200,
               decoration: request.status == 0 
                ? TextDecoration.none
                  : TextDecoration.lineThrough

            ),),
            trailing: Checkbox(
              onChanged: (value){
                request.status = value! ? 1 : 0;
                RequestHelper.instance.updateRequest(request);
                _updateRequestsList();
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Requests()));
              },
              activeColor: Theme.of(context).primaryColor,
              value: request.status == 1 ? true : false,
            ),
            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => AddRequest(
                updateRequestList: _updateRequestsList(),
                request: request,
            ))),
            isThreeLine: true,
            leading: Icon(Icons.pending_actions),
          ),
          Divider(height: 20, color: Colors.indigo, thickness: 1,),
        ],
      ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panding Requests'),
        backgroundColor: Colors.indigo.shade400,
        centerTitle: true,
        leading: IconButton(
             icon: Icon(Icons.arrow_back_ios_new,size: 30,),
             onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPage()));
             
             },
      ),
      ),
       backgroundColor: Colors.white,
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.indigo,
         onPressed: () {
           Navigator.push(context, CupertinoPageRoute(builder: (_) => AddRequest(
             updateRequestList: _updateRequestsList,
           ),));
         },
         child: Icon(Icons.add),
       ),
       body: FutureBuilder(
         
         future: _requestList,
         builder: (context, AsyncSnapshot snapshot){
           if(!snapshot.hasData){
             return Center(
               child: CircularProgressIndicator(),
             );
           }

           final int completedRequestCount = snapshot.data!.where((RequestsDB request) => request.status == 1).toList().length;

       return ListView.builder(
         padding: EdgeInsets.symmetric(vertical: 80),
         itemCount: int.parse(snapshot.data!.length.toString()) + 1,
         itemBuilder: (BuildContext context , int index){
           if(index == 0){
             return Padding(
               padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "My Requests",
                     style: TextStyle(
                       color: Colors.indigo,
                       fontSize: 40,
                       fontWeight: FontWeight.bold,
                     ),
                     ),
                     SizedBox(height: 25,),
                     Text(
                       '$completedRequestCount of ${snapshot.data.length}',
                       style: TextStyle(
                         color: Colors.indigo,
                         fontSize: 15,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                ],
               )
             );
           }
           return _buildRequests(snapshot.data![index - 1]);
         }
      );
  }
    ),
    );
  }
}