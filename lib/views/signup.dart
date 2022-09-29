import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/profile.dart';
import 'package:my_project/views/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
             return Scaffold(
      // backgroundColor: Colors.orange,
      body: Form(
        key: _formKey,
      
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  keyboardType: TextInputType.emailAddress ,
                  validator: MultiValidator([
                    EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                  ]),
                  decoration: InputDecoration(hintText: "Email"),
                  onSaved: (val) {
                    profile.email = val!;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val!.isEmpty ? "Enter Password" : null;
                  },
                  decoration: InputDecoration(hintText: "Password"),
                  onSaved: (val) {
                    profile.password = val!;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                
                GestureDetector(
                  onTap: ()   {
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                        try{
                           FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: profile.email, password: profile.password
                          ).then((value) {
                              _formKey.currentState!.reset();
                        
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return SignIn();
                        }));
                          });
                          
                        
                        }on FirebaseAuthException catch(e){
                            print(e.code);
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
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 48,
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
        
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => SignIn())));
                        },
                        child: Text(
                          "Sign In",
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
