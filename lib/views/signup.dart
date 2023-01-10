import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_project/main_page.dart';
import 'package:my_project/service/database_service.dart';
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

  File? _image;
  String? _imageUrl;
  final picker = ImagePicker();

  void _showImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('โปรดใส่รูปภาพ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            InkWell(
              onTap: () {
                //
                imagePicker();
              },
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.camera, color: Colors.black,),
                    ),
                    Text('Gallery')
                ],
              ),
            )
          ]),
        );
      });
  }

  Future imagePicker() async {
    try{
      final pick =  await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null) {
        _image = File(pick.path);
      }else{
        showSnackbar(context, Colors.red , "ไม่มีรูปภาพ");
      }
    });
    } catch (e) {
      showSnackbar(context , Colors.red , e.toString());
    }
    
  }

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('users').child('user$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }
  

  @override
  Widget build(BuildContext context) {

    final imageUser = GestureDetector(
      onTap: () {
        // createimage
        imagePicker();
        Navigator.of(context);

      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.purple,
              child: _image == null ?
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey,
                child: Text('โปรดใส่รูปภาพ', style: TextStyle(color: Colors.white),),
              )
              : CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey,
                backgroundImage: FileImage(_image!),
              )
            )
          ],
        ),
      )
    );

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
            width: 1000,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      imageUser,
                      SizedBox(height: 20,),
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
      if(_image == null) {
        showSnackbar(context, Colors.red, "โปรดเพิ่มรูปภาพ");
        return;
      }
      try{
        await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
                showSnackbar(context, Colors.green, "เข้าสู่ระบบสำเร็จแล้ว");
                postDetailsToFirestore(email,type,firstName,lastName );
      }catch(e) {
        showSnackbar(context, Colors.red, e.toString() );
      }
      
    }
  }
  

  postDetailsToFirestore(
    String email, String type, String firstName, String lastName) async {

    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    final User? user = _auth.currentUser;
    final _uid = user!.uid;
    final _imageUrl = await uploadImage(_image!);
    FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'email': emailEditingController.text,
      'firstName': firstNameEditingController.text,
      'lastName': lastNameEditingController.text,
      'type': type,
      'imageUrl' : _imageUrl,
      // 'quizs' : [],
      'uid' : _uid,
      'createdAt' : "$date $time",
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(fontSize: 14),),
    backgroundColor: color,
    duration: Duration(seconds: 5),
    ));
  }
}