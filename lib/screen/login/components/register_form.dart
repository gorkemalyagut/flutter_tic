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
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final GestureTapCallback tapEvent;
  final double defaultLoginSize;
  final AnimationController animationController;


  @override
  _RegisterFormState createState() => new _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();
  bool _isLoading = false;
  late  String _mail,_username,_password;
  late final UserHelper db;
  late User user;

  void initState() {
    super.initState();
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
                key: formKey,
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
                  SizedBox(height: 100),
                   TextFormField(
                            controller: mailController,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (val) => _mail = val!,
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
                              contentPadding: EdgeInsets.only(top: 50),
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
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "Please enter your email";
                              }
                              return null;
                            }
                            
                          ),
                  SizedBox(height: 50),
                  TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            onSaved: (val) => _username = val!,
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
                              contentPadding: EdgeInsets.only(top: 50),
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
                            validator: (value) {
                                if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                }
                              return null;
                          },
                      ),
                  SizedBox(height: 50),
                  TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onSaved: (val) =>  _password = val!,
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
                              contentPadding: EdgeInsets.only(top: 50),
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
                            validator: (value) {
                                if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                }
                              return null;
                          },
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
                          onPressed: () async {
                            if(formKey.currentState!.validate())
                            {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.success,
                                text: "Your register was successful!",
                              );
                                return;
                            }else{
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                text: "Your register was error!",
                              );
                            }
                            _mail = mailController.text;
                            _username = usernameController.text;
                            _password = passwordController.text;
                            var user = User(mail: _mail, name: _username, password: _password);
                            await db.insertUser(user);
                            },
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