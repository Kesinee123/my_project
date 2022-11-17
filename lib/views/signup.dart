import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
// import 'model.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  _SignUpState();

  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmpasswordEditingController = new TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var options = [
    'Student',
    'Teacher',
  ];
  var _currentItemSelected = "Student";
  var rool = "Student";

  @override
  Widget build(BuildContext context) {
    final firstNamefileld = TextFormField(
      autofocus: false,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name connot be Empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid First Name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      keyboardType: TextInputType.name,
      controller: firstNameEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 15),
          hintText: 'First Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final lastNamefileld = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Last Name connot be Empty");
        }
        if (!regExp.hasMatch(value)) {
          return ("Enter Valid Last Name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 15),
          hintText: 'Last Name',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "Plase Enter Your @dpu.ac.th";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[dpu]+.[ac]+.[th]").hasMatch(value)) {
          return ("Plase Enter a valid Email-DPU");
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordfield = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Password is required for login");
        }
        if (!regExp.hasMatch(value)) {
          return ("Please Enter Valid Password(Min. 6 Character)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final confrimPasswordfield = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmpasswordEditingController.text !=
            passwordEditingController.text) {
          return "Password don't match";
        }
        return null;
      },
      onSaved: (value) {
        confirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Confirm Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final typefiled = Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Type : ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          DropdownButton<String>(
            hint: Text('Select Types'),
            dropdownColor: Colors.white,
            isDense: true,
            isExpanded: false,
            iconEnabledColor: Colors.black,
            focusColor: Colors.white,
            items: options.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(
                  dropDownStringItem,
                  style: TextStyle(
                    color: Colors.black,
                    
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValueSelected) {
              setState(() {
                _currentItemSelected = newValueSelected!;
                rool = newValueSelected;
              });
            },
            value: _currentItemSelected,
          ),
        ],
      ),
    );

    final signUpButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Fluttertoast.showToast(
              msg: "รบกวนรอซักครู่....",
            );
            setState(() {
          showProgress = true;
        });
        signUp(
            emailEditingController.text,
            passwordEditingController.text,
            rool,
            firstNameEditingController.text,
            lastNameEditingController.text);
        },
        child: Text(
          'SignUp',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.purple,
            )),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      firstNamefileld,
                      SizedBox(
                        height: 20,
                      ),
                      lastNamefileld,
                      SizedBox(
                        height: 20,
                      ),
                      // type
                      typefiled,
                      SizedBox(
                        height: 20,
                      ),
                      emailField,
                      SizedBox(
                        height: 20,
                      ),
                      passwordfield,
                      SizedBox(
                        height: 20,
                      ),
                      confrimPasswordfield,
                      SizedBox(
                        height: 30,
                      ),
                      signUpButton,
                      SizedBox(
                        height: 20,
                      ),
                      // Text("I am a member !!")
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool, String firstName,
      String lastName) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(email, rool, firstName, lastName)})
          .catchError((e) {});
    }
  }

  postDetailsToFirestore(
      String email, String rool, String firstName, String lastName) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'email': emailEditingController.text,
      'firstName': firstNameEditingController.text,
      'lastName': lastNameEditingController.text,
      'rool': rool
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
