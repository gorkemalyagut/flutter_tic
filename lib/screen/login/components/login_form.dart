import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tic/models/user.dart';
import 'package:flutter_tic/models/users_database.dart';
import 'package:flutter_tic/screen/login/components/profil_form.dart';


class LoginForm extends StatefulWidget {
   LoginForm({ 
    Key? key, 
    required this.isLogin, 
    required this.animationDuration, 
    required this.size, 
    required this.defaultLoginSize,
    }) : super(key: key);

    final bool isLogin;
    final Duration animationDuration;
    final Size size;
    final double defaultLoginSize;

  
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _username = '';
  String _password = '';
  bool _isLoading = false;
  late User user;
  late UserHelper? helper;


  _loginUserBtn(){
    if(_formKey.currentState!.validate()){

      _username = _usernameController.text;
      _password = _passwordController.text;
      print('{$_username,$_password}');

      UserHelper.instance.checkLogin(_usernameController.text, _passwordController.text).then((value) => {
        if(value != null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPage())),
        }
        else{
          CoolAlert.show(
            context: context,
            type: CoolAlertType.warning,
            text: "Your login was error!",),
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: GestureDetector(
        child: Stack(
            children: <Widget>[
              Container(
                //Logın type and page decoration
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 100,
                  ),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                          margin: EdgeInsets.only(top: 130),
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                              fontSize: 30,
                            ),
                          ),
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
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 24),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 16),
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),
                            controller: _usernameController,
                            validator: (input){
                              if(input == null || input.isEmpty){
                                return "Please enter your username";
                              }
                              return null;
                            }
                          
                          ),
                      SizedBox(height: 40),
                      TextFormField(
                            obscureText: true,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                           decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.indigo.shade50,
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(width: 1,color: Colors.indigo.shade700),
                              ),
                              contentPadding: EdgeInsets.only(top: 24),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.indigoAccent.shade400,
                              ),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 16),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.indigoAccent.shade100,
                              ),
                            ),
                            controller: _passwordController,
                            validator: (input) {
                                if (input == null || input.isEmpty) {
                                    return 'Please enter your password';
                                }
                              return null;
                          },
                      ),
                      Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.symmetric(vertical: 50),
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
                                onPressed: _loginUserBtn,
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              opacity: widget.isLogin ? 1.0 : 0.0,
                              duration: widget.animationDuration * 4,
                            ),
                  ],
                ),
              ),
              ),
            ],
        ),
      ),
    );
  }

}

