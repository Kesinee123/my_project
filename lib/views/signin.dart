import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/models/user_detial.dart';
import 'package:my_project/models/usermodel.dart';
import 'package:my_project/views/signup.dart';
import 'package:my_project/views/views_students/homeStudent.dart';
import 'package:my_project/views/views_teachers/forgetPassword.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // String? name, email, uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image(image: AssetImage('assets/logo.png')),
            // FlutterLogo(size: 120,),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Welcome\nBack',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login to you account to continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(onPressed: () => processSignInWithGoogle(context),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              minimumSize: Size(double.infinity, 50),
            ),
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red,),
            label: Text('Sign in With Google')),
            SizedBox(
              height: 40,
            ),
            RichText(
              text: TextSpan(text: 'Already have an account?', children: [
                TextSpan(
                    text: 'Log in',
                    style: TextStyle(decoration: TextDecoration.underline))
              ]),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> processSignInWithGoogle(context) async {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  await Firebase.initializeApp().then((value) async {
    await _googleSignIn.signIn().then((value) async {
      String? name = value?.displayName;
      String? email = value?.email;
      // print('Login with gmail success : name = $name , email = $email');
      await value!.authentication.then((value2) async {
        AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: value2.idToken, accessToken: value2.accessToken);
        await FirebaseAuth.instance
            .signInWithCredential(authCredential)
            .then((value3) async {
          String date = DateFormat.yMMMMd().format(DateTime.now());
          String time = DateFormat.Hm().format(DateTime.now());
          String uid = value3.user!.uid;

         RegExp emailTeacher = RegExp(r'[A-Za-z0-9]+@gmail+.com');
         RegExp emailStudent = RegExp(r'[0-9]+@dpu+.ac.th');

          print(
              'Login with gmail success : name = $name , email = $email uid = $uid');
          if(emailTeacher.hasMatch(email!)){
            await FirebaseFirestore.instance.collection('user').doc(uid).set({
            'email': email,
            'name': name,
            'uid': uid,
            'createdAt' : '$date $time',
            'type' : 'คุณครู'
          });
          }else{
             await FirebaseFirestore.instance.collection('user').doc(uid).set({
            'email': email,
            'name': name,
            'uid': uid,
            'createdAt' : '$date $time',
            'tpye' : 'นักเรียน'
          });
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
         
        });
      });
    });
  });
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: Duration(seconds: 5),
  ));
}
