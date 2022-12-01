
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/views/signup.dart';
import 'package:my_project/views/views_teachers/homepage.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  bool _isVisible = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final _auth = FirebaseAuth.instance;

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //     email: emailController.text.trim(), password: passwordController.text.trim());
  // }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) { 
    final emailField = Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextFormField(
        controller: emailController,
        autofocus: false,
       
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if(value!.isEmpty){
            return "โปรดกรอกอีเมลที่เป็น @dpu.ac.th";
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[dpu]+.[ac]+.[th]").hasMatch(value)) {
            return ("โปรดกรอกอีเมลที่เป็น @dpu.ac.th");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'อีเมล',
            border: InputBorder.none),
        onSaved: (value) {
          emailController.text = value!;
        },
      ),
    );

    final passwordfiele = Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey))),
      child: TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: !_isVisible,
        onSaved: (value){
          passwordController.text = value!;
        },
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if(value!.isEmpty){
            return ("โปรดกรอกรหัสผ่านเพื่อเข้าสู่ระบบ");
          }
          if(!regex.hasMatch(value)){
            return("โปรดกรอกรหัสผ่านเพื่อเข้าสู่ระบบ");
          }
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: (){
              setState(() {
                _isVisible = !_isVisible;
              });
            },
            icon: _isVisible ? Icon(Icons.visibility,) : Icon(Icons.visibility_off)),
            prefixIcon: Icon(Icons.vpn_key),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'รหัสผ่าน',
            border: InputBorder.none,
            
            ),
      ),
    );

    final signInButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          
            signIn(emailController.text, passwordController.text);
        },
        child: Text(
          'เข้าสู่ระบบ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
             return Scaffold(
      // backgroundColor: Colors.orange,
     body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.deepPurple, Colors.purple])),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 800,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  width: 800,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 176, 97, 255),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                emailField,
                              SizedBox(height: 20,),
                               passwordfiele],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        signInButton,
                       
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                          Text("ยังไม่มีบัญชี ?"),
                          TextButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                            }, child: Text('ลงทะเบียน' , style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black),),),
                         ],
                       ),
                        SizedBox(
                          height: 20,
                        ),
                        // googleSignIn
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  };
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
   
  }
  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()){
      await _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
        showSnackbar(context, Colors.green, "Login Successfull" ),
        // Fluttertoast.showToast(msg: "Login Successfull"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainPage()))
      }).catchError((e){
        showSnackbar(context, Colors.red, e!.message);
        // Fluttertoast.showToast(msg: e!.message);
        }
      );
    }
  }
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 14),),
      backgroundColor: color,
      duration: Duration(seconds: 5),
      ));
}