import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic/models/request.dart';
import 'package:flutter_tic/models/request_db.dart';
import 'package:flutter_tic/page/requests_page.dart';
import 'package:intl/intl.dart';

class AddRequest extends StatefulWidget {

  final RequestsDB? request;
  final Function? updateRequestList;

  AddRequest({this.request,this.updateRequestList});

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {

  final _formKey = GlobalKey<FormState>();
  String _priority = 'Low';
  String _fullname = '';
  String _type = '';
  String _description = '';
  String _phone = '';
  String titleText = "Add Request";
  String btnText = "Add Request";
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low','Medium','High'];
  DateTime _date = DateTime.now();

  @override
  void initState(){
    super.initState();

    if(widget.request != null){
      
      _date = widget.request!.date!;
      _priority = widget.request!.priority!;
      _fullname = widget.request!.fullname!;
      _phone = widget.request!.phone!;
      _type = widget.request!.type!;
      _description = widget.request!.description!;

      setState(() {
        btnText = "Update Request";
        titleText = "Update Request";
      });
    }
    else {
      setState(() {
        btnText = "Add Request";
        titleText = "Add Request";
      });
    }
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose(){
    _dateController.dispose();
    super.dispose();
  }

  _handleDatePicker() async{
    final DateTime? date = await showDatePicker(
      context: context, 
      initialDate: _date, 
      firstDate: DateTime(2000),
      lastDate: DateTime(2050));
    if(date != null && date != _date){
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

   _delete () {
    RequestHelper.instance.deleteRequest(widget.request!.id!);
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => Requests()));
    widget.updateRequestList!();

  }

  _submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('$_fullname, $_date,$_description,$_type,$_priority,$_phone');
      
      RequestsDB request = RequestsDB(
        date: _date,
        priority: _priority,
        fullname: _fullname,
        phone: _phone,
        type: _type,
        description: _description,
      );

      if(widget.request == null){
        request.status = 0;
        RequestHelper.instance.insertRequest(request);

        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => Requests()));
      }
      else{
        request.id=widget.request!.id;
        request.status = widget.request!.status;
        RequestHelper.instance.updateRequest(request);
        
        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (_) => Requests()));
        
      }
      widget.updateRequestList!();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(titleText),
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
      body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 25),
            Form(
              key:_formKey,
              child: Column(
                children: <Widget> [
              TextFormField(
                readOnly: true,
                controller: _dateController,
                style: TextStyle(fontSize: 20),
                onTap: _handleDatePicker,
                decoration: InputDecoration(
                  icon: Icon(Icons.date_range_outlined, color: Colors.indigo,size: 30,),
                  hintStyle: TextStyle(fontSize: 20, color: Colors.indigo.shade300),
                  hintText: "Date",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),
                  labelText: "Date",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.indigo,
                    ),
                  ),
                ),
          ),
          SizedBox(height: 25),
          TextFormField(
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
                validator: (input) => 
                  input!.trim().isEmpty ? 'Please enter your name' : null,
                onSaved: (input) => _fullname = input!,
                initialValue: _fullname,
          ),
          SizedBox(height: 25),
          TextFormField(
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
                validator: (input) => 
                  input!.trim().isEmpty ? 'Please enter your phone' : null,
                onSaved: (input) => _phone = input!,
                initialValue: _phone,
          ),
          SizedBox(height: 25),
          TextFormField(
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
                validator: (input) => 
                  input!.trim().isEmpty ? 'Please enter your type' : null,
                onSaved: (input) => _type = input!,
                initialValue: _type,
          ),
                  SizedBox(height: 25),
          TextFormField(
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
                validator: (input) => 
                  input!.trim().isEmpty ? 'Please enter your description' : null,
                onSaved: (input) => _description = input!,
                initialValue: _description,
          ),
          SizedBox(height: 40,),
          DropdownButtonFormField(
            isDense: true,
            icon: Icon(Icons.arrow_drop_down_circle),
            iconSize: 22,
            iconEnabledColor: Colors.indigo,
            items:_priorities.map((String priority){
              return DropdownMenuItem(
                value: priority,
                child: Text(
                  priority,
                  style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 18,
                  ),
                ),
              );
              }).toList(),
              style: TextStyle(fontSize: 18,),
              decoration: InputDecoration(
                labelText: 'Priority',
                labelStyle: TextStyle(fontSize: 18, color: Colors.indigo,fontWeight: FontWeight.bold),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              ),
              validator: (input) => _priority == null ? 'Please select a priority level' : null,
              onChanged: (value){
                setState(() {
                  _priority = value.toString();
                });
              },
              value: _priority,
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomCenter,
            child:ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigoAccent,
              shadowColor: Colors.indigoAccent,
              elevation: 10,
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              btnText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 19,
              ),
              ),
              onPressed: _submit,
            ),
          ),
          widget.request != null ? Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Colors.indigoAccent,
                shadowColor: Colors.indigoAccent,
                elevation: 10,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Delete Request',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
              onPressed: _delete,
            ),
          ): SizedBox.shrink()
          ],
          ),
        ),
        ],
        
      ),
    ),
  ),
  );
}