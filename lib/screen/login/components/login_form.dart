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
    required this.defaultLoginSize 
    
    }) : super(key: key);

    final bool isLogin;
    final Duration animationDuration;
    final Size size;
    final double defaultLoginSize;

  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   late BuildContext _ctx;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();
  late User user;
  late String _mail;
  late String _password;
  late UserHelper db = new UserHelper();
   bool _isLoading = false;

    void initState() {
    super.initState();
    this.db = new UserHelper();
    this.db.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return Form(
      key: formKey,
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
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.indigo..shade700, fontWeight: FontWeight.bold,fontSize: 16),
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
                      SizedBox(height: 40),
                      TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            onSaved: (val) => _password = val!,
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
                            validator: (value) {
                                if (value == null || value.isEmpty) {
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
                                onPressed: () { 
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPage()));
                                    if(formKey.currentState!.validate())
                                    {
                                      _submit();
                                      scaffoldMessengerKey.currentState!.showSnackBar(new SnackBar(content: 
                                      new Text("Login Success"),));
                                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPage()));
                                      
                                    }else{
                                      scaffoldMessengerKey.currentState!.showSnackBar(new SnackBar(content: 
                                        new Text("Login error!"),));
                                    }
                                },
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
  void _submit() {
    final form = formKey.currentState;
    if (form!.validate()) {
      setState(() async {
        _isLoading = true;
        form.save();
         await db.getLogin(_mail, _password);
      });
    }
  }
}

