// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_project/models/usermodel.dart';
// import 'package:my_project/views/signin.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   String? name , email , password;

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final userNamefileld = TextFormField(
//       autofocus: false,
//       validator: (value) {
//         RegExp regExp =  RegExp(r'^.{3,}$');
//         if(value!.isEmpty) {
//             return ("User Name connot be Empty");
//         }
//         if(!regExp.hasMatch(value)) {
//           return ("Enter Valid Name(Min. 3 Character)");
//         }
//         return null;
//       },
//      onChanged: (value) => name = value.trim(),
     
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.account_circle),
//           contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 15),
//           hintText: 'User Name',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

//     final emailField = TextFormField(
//       autofocus: false,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return ('Please Enter Your EmailDPU');
//         }
//         if (!RegExp("^[a-zA-Z0-9+_.-]+@[dpu]+.[a-z]").hasMatch(value)){
//           return ("Please Enter a valid email");
//         }
//         return null;
//       },
//       onChanged: (value) => email = value.trim(),
      
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.mail),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Email',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

//     final passwordfield = TextFormField(
//       autofocus: false,
//      obscureText: true,
//      validator: (value) {
//         RegExp regExp =  RegExp(r'^.{6,}$');
//         if(value!.isEmpty) {
//             return ("Password is required for login");
//         }
//         if(!regExp.hasMatch(value)) {
//           return ("Please Enter Valid Password(Min. 6 Character)");
//         }
//       },
//       onChanged:(value) => password = value.trim(),
     
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.vpn_key),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Password',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

    

//     final signUpButton = Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(30),
//       color: Colors.purple,
//       child: MaterialButton(
//         padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//         minWidth: MediaQuery.of(context).size.width,
//         onPressed: () {
//           if(_formKey.currentState!.validate()){
//               print('Have Space');
//           }else{
//             createAccountAndInsetInformation();
//           }
//         },
//         child: Text(
//           'SignUp',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//               fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(onPressed: () {
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back, color: Colors.purple,)),
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             color: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.all(36.0),
//               child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
                     
//                       userNamefileld,
//                       SizedBox(
//                         height: 20,
//                       ),
                    
//                       emailField,
//                       SizedBox(
//                         height: 20,
//                       ),
//                       passwordfield,
//                       SizedBox(
//                         height: 20,
//                       ),
                     
//                       signUpButton,
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Future<Null> createAccountAndInsetInformation() async {
//     await Firebase.initializeApp().then((value) => print('### Firebase Success ###'));
//   }
// }