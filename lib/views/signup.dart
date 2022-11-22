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
  bool _isVisible = false;
  bool _isVisible2 = false;



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
    'นักเรียน',
    'คุณครู',
  ];
  var _currentItemSelected = "นักเรียน";
  var type = "นักเรียน";

  @override
  Widget build(BuildContext context) {
    final firstNamefileld = TextFormField(
      autofocus: false,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("โปรดกรอกชื่อจริง");
        }
        if (!regExp.hasMatch(value)) {
          return ("โปรดกรอกชื่อจริง(ต้องมากกว่า 3 ตัวอักษร)");
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
          hintText: 'ชื่อจริง',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final lastNamefileld = TextFormField(
      autofocus: false,
      controller: lastNameEditingController,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("โปรดกรอกนามสกุล");
        }
        if (!regExp.hasMatch(value)) {
          return ("โปรดกรอกนามสกุล(ต้องมากกว่า 3 ตัวอักษร)");
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
          hintText: 'นามสกุล',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return "โปรดกรอกอีเมลที่เป็น @dpu.ac.th";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[dpu]+.[ac]+.[th]").hasMatch(value)) {
          return ("โปรดกรอกอีเมลที่เป็น @dpu.ac.th");
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
          hintText: 'อีเมล',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final passwordfield = TextFormField(
      obscureText: !_isVisible,
      autofocus: false,
      controller: passwordEditingController,
      validator: (value) {
        RegExp regExp = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("โปรดกรอกรหัสผ่าน");
        }
        if (!regExp.hasMatch(value)) {
          return ("โปรดกรอกรหัสผ่าน(ต้องมากกว่า 6 ตัวอักษร)");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final confrimPasswordfield = TextFormField(
      autofocus: false,
      controller: confirmpasswordEditingController,
      obscureText: !_isVisible2,
      validator: (value) {
        if (confirmpasswordEditingController.text !=
            passwordEditingController.text) {
          return "รหัสผ่านไม่ตรงกัน";
        }
        return null;
      },
      onSaved: (value) {
        confirmpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: (){
              setState(() {
                _isVisible2 = !_isVisible2;
              });
            },
            icon: _isVisible2 ? Icon(Icons.visibility,) : Icon(Icons.visibility_off)),
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'ยืนยันรหัสผ่าน',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final typefiled = Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "ประเภท : ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          DropdownButton<String>(
            // hint: Text('Select Types'),
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
                type = newValueSelected;
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
            setState(() {
          showProgress = true;
        });
        
        signUp(
            emailEditingController.text,
            passwordEditingController.text,
            type,
            firstNameEditingController.text,
            lastNameEditingController.text);
           
        },
        child: Text(
          'ลงทะเบียน',
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

  void signUp(String email, String password, String type, String firstName,
      String lastName) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {
                Fluttertoast.showToast(msg: "Login Successfull"),
                postDetailsToFirestore(email, type, firstName, lastName,)})
          .catchError((e) {
                    Fluttertoast.showToast(msg: e!.message);
          });
    }
  }

  postDetailsToFirestore(
      String email, String type, String firstName, String lastName) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({
      'email': emailEditingController.text,
      'firstName': firstNameEditingController.text,
      'lastName': lastNameEditingController.text,
      'type': type,
      'uid' : _auth.currentUser!.uid
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
