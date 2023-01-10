import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/signin.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'อีเมลที่ใช้ในการสมัคร',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    final signInButton = Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(30),
      color: Colors.purple,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            try{
            await _auth.sendPasswordResetEmail(email: emailController.text); 
            showSnackbar(context, Colors.green, 'รีเซ็ตรหัสผ่านสำเร็จ');
          }
          on FirebaseAuthException catch(error) {
            showSnackbar(context, Colors.red , error.toString());
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
          }
        },
        child: Text(
          'ส่งลิ้งค์',
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
        
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey ,
              child: Container(
                width: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ลืมรหัสผ่านหรือไม่', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 30,),
                    Image.asset('assets/forgetpassword.png'),
                    SizedBox(height: 30,),
                    Container(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: emailField
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: signInButton),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn(),));
                      },
                      child: Text('มีบัญชีอยู่แล้ว'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(fontSize: 14),),
      backgroundColor: color,
      duration: Duration(seconds: 5),
      ));
}
}