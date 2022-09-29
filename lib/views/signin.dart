import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/models/profile.dart';
import 'package:my_project/views/homepage.dart';
import 'package:my_project/views/signup.dart';
import 'package:flutter/src/rendering/box.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: 'email', password: 'password');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) { 
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40), 
              child: Column(    
                children: [
                  Image(image: AssetImage("assets/logo.png"),height: 350,),
                  TextFormField(
                    validator: (val) { return val!.isEmpty ?  "Enter Email" : null; },
                    decoration: InputDecoration(
                      hintText: "Email"
                       ),
                       onChanged: (val) {
                        profile.email = val;
                       },
                  ),
                  SizedBox(height: 6,),
                  TextFormField(
                    obscureText: true,
                    validator: (val) { return val!.isEmpty ?  "Enter Password" : null; },
                    decoration: InputDecoration(
                      hintText: "Password"
                       ),
                       onChanged: (val) {
                        profile.password = val;
                       },
                  ),
                  SizedBox(height: 24,),
          
                  GestureDetector(
                   onTap: ()   {
                      if (_formKey.currentState!.validate()){
                        _formKey.currentState!.save();
                          try{
                             FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: profile.email, password: profile.password
                            ).then((value) {
                                _formKey.currentState!.reset();
                          Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context){
                              return HomePage();
                          }));
                            });
                            
                          
                          }on FirebaseAuthException catch(e){
                              print(e.message);
                              // String message;
                              // if(e.code == 'email-already-in-use'){
                              //   message = "มีอีเมลนี้ในระบบแล้วค่า" ;
                              // }
                              // // print(e.message);
                              // Fluttertoast.showToast(
                              //     msg: message ,
                              //     gravity: ToastGravity.TOP
                              //   );
                          }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ) ,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 48 ,
                      child: Text("Sign in" ,style: TextStyle(color: Colors.white,fontSize: 16),) ,
                    ),
                  ),
          
                  SizedBox(height: 18,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?" ,style: TextStyle(fontSize: 16),),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp() )));
                        },
                         child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  )
                ],
              ),
            ),
        ),
      ),
    );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
   
  }
}