import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:my_project/config/responsive.dart';
import 'package:my_project/main_page.dart';


class SignIn extends StatefulWidget {

  final String path;

  const SignIn({super.key, required this.path});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.purple,
        body: SizedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Responsive(
                mobile: 
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                        height: height,
                        color: Colors.purple,
                        child: Column(
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            const Spacer(),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Welcome\nBack',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                            const SizedBox(
                                height: 8,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Login to you account to continue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(onPressed: () => processSignInWithGoogle(context),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red,),
                              label: const Text('Sign in With Google')),
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        )),
                  )),
                  // Destop Page
                  destop: 
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      margin: EdgeInsets.only(
                      left: 500,
                      right: 500
                     ),
                        // height: height,
                        color: Colors.purple,
                        child: Column(
                          children: [
                            const Center(
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                                height: 300,
                                width: 300,
                              ),
                            ),
                            const Spacer(),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Welcome\nBack',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 30),
                              ),
                            ),
                            const SizedBox(
                                height: 8,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Login to you account to continue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(onPressed: () => processSignInWithGoogle(context),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red,),
                              label: const Text('Sign in With Google')),
                              const SizedBox(
                                height: 40,
                              ),
                          ],
                        )),
                  )),
              ),
              
            ],
          ),
        ));
  }
}

Future<void> processSignInWithGoogle(context) async {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '506605725552-i11mklihemnuda6uoknjg5b1i2egpo3d.apps.googleusercontent.com',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  try {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final User user = userCredential.user!;
    final String uid = user.uid;

    RegExp emailTeacher = RegExp(r'[A-Za-z0-9]+@gmail+.com');
    RegExp emailStudent = RegExp(r'[0-9]+@dpu+.ac.th');
    
    final String? name = user.displayName;
    final String? email = user.email;
    final String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String time = DateFormat.Hm().format(DateTime.now());

    print('Login with Gmail success: name = $name, email = $email, uid = $uid');

    if (emailTeacher.hasMatch(email!)) {
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'email': email,
        'name': name,
        'uid': uid,
        'createdAt': '$date $time',
        'imageUrl': user.photoURL,
        'type': 'คุณครู'
      });
    } else {
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'email': email,
        'name': name,
        'uid': uid,
        'createdAt': '$date $time',
        'imageUrl': user.photoURL,
        'type': 'นักเรียน'
      });
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainPage(path: '',)));
  } catch (e) {
    print('Error signing in with Google: $e');
  }
}



void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 5),
  ));
}
