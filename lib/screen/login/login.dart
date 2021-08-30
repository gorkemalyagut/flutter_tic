import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tic/screen/login/components/login_form.dart';
import 'package:flutter_tic/screen/login/components/register_form.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {

  bool isLogin = true;
  late Animation<double> containerSize;
  late AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 270);
  bool isRememberMe = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    animationController = AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController, curve: Curves.linear));
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),),
          ),
          // Lets add some decorations
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/top1.png",
              width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/top2.png",
              width: size.width
            ),
          ),
          Positioned(
            top: 70,
            left: 10,
            child: Image.asset(
              "assets/images/main.png",
              width: size.width * 0.35
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/bottom1.png",
              width: size.width
            ),
          ),
          
          
          //Login Form
          LoginForm(isLogin: isLogin, animationDuration: animationDuration, size: size, defaultLoginSize: defaultLoginSize, key: null),
          
          //Register Container
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              if (viewInset == 0 && isLogin) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }
              // Returning empty container to hide the widget
              return Container();
            },
          ),
          //RoundedButtonClick(),
          // Register Form
          
          RegisterForm(isLogin: isLogin, animationDuration: animationDuration, size: size, defaultLoginSize: defaultRegisterSize, tapEvent: () {  }, animationController: animationController,),
          buildRememberClk(),
          buildForgotPassBtn(),
          buildRegisterCancelBtn(),
       ],
      ),
    );
  }
  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: Colors.indigoAccent,
        
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin ? null : () {
            animationController.forward();
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: isLogin ? Text(
            "Don't have an account? Sign up",
            style: TextStyle(
            color: Colors.white,
            fontSize: 18
            ),
          ) : null,
        ),
      ),
    );
  }
  Widget buildRememberClk(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 260),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.indigoAccent),
            child: Checkbox(
              checkColor: Colors.indigoAccent.shade400,
              activeColor: Colors.indigoAccent.shade100,
              value: isRememberMe, 
              onChanged: (value){
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
            ),
            Text(
              "Remember Me",
              style: TextStyle(
                color: Colors.indigoAccent,
                fontWeight: FontWeight.bold,
              ),
              ),
        ],
      ),
    );
  }
  Widget buildForgotPassBtn(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 260),
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () => print("Forgot Password Pressed"),
        child: Text(
          "Forgot Password ?",
           style: TextStyle(
             color: Colors.indigoAccent,
             fontWeight: FontWeight.bold,
           ),
          ),
      ),
    );
  }
  Widget buildRegisterCancelBtn(){
    Size size = MediaQuery.of(context).size;
    return AnimatedOpacity(
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: size.width,
          height: size.height * 0.1,
          alignment: Alignment.bottomCenter,

          child: IconButton(
            icon: Icon(Icons.close),
            onPressed:  (){
               animationController.reverse();
               setState(() {
                 isLogin = !isLogin;
               });
            },
            color: Colors.black87,
          ),
        ),
      ),
    );
   }
}



