import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic/models/user.dart';
import 'package:flutter_tic/models/users_database.dart';

class RegisterForm extends StatefulWidget {

  RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
    required this.animationController,
    required this.tapEvent,
    this.user,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final GestureTapCallback tapEvent;
  final double defaultLoginSize;
  final AnimationController animationController;
  final User? user;

  @override
  _RegisterFormState createState() => new _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  String _email = '';
  String _name = '';
  String _username = '';
  String _password = '';

  final _formKey = GlobalKey<FormState>();

  _submit(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print('$_email, $_name,$_username,$_password');
      
      User user = User(
        mail: _email,
        name: _name,
        username: _username,
        password: _password,
      );

      if(widget.user == null){
        UserHelper.instance.insertUser(user);
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: "Your register was successful!",
        );
      }
      else{
         CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          text: "Your register was error!",
        );
        
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(top: 120),
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  SizedBox(height: 40),
                   TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 40),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 24),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),

                            validator: (input) => 
                              input!.trim().isEmpty ? 'Please enter your email' : null,
                            onSaved: (input) => _email = input!,
                            initialValue: _email,

                          ),
                  SizedBox(height: 50),
                  TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),

                           decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 40),
                              prefixIcon: Icon(
                                Icons.people,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 24),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),

                            validator: (input) => 
                              input!.trim().isEmpty ? 'Please enter your name' : null,
                            onSaved: (input) => _name = input!,
                            initialValue: _name,

                      ),
                  SizedBox(height: 50),
                  TextFormField(
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 40),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 24),
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),

                            validator: (input) => 
                              input!.trim().isEmpty ? 'Please enter your username' : null,
                            onSaved: (input) => _username = input!,
                            initialValue: _username,
                            
                          ),
                  SizedBox(height: 50,),
                  TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                           decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 40),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 24),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),

                            validator: (input) => 
                              input!.trim().isEmpty ? 'Please enter your password' : null,
                            onSaved: (input) => _password = input!,
                            initialValue: _password,

                      ),
                  SizedBox(height: 50),
                  Container(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigoAccent,
                            shadowColor: Colors.indigoAccent,
                            elevation: 10,
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            )
                          ),
                          onPressed: _submit,
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
          ),
        ),
      ),
    );
  }
}