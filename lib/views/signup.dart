// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_project/models/userT.dart';
// import 'package:my_project/views/homepage.dart';
// import 'package:my_project/views/signin.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({super.key});

//   @override
//   State<SignUp> createState() => _SignUpState();

//   void signUpMessageHandler() {}
// }

// class _SignUpState extends State<SignUp> {
//   String? typeUser;

//   final _auth = FirebaseAuth.instance;

//   final _formKey = GlobalKey<FormState>();

//   final userNameEditingController = TextEditingController();
//   final emailEditingController = TextEditingController();
//   final passwordEditingController = TextEditingController();
//   final confirmEditingController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final userNamefileld = TextFormField(
//       autofocus: false,
//       controller: userNameEditingController,
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
//       onSaved: (value) {
//         userNameEditingController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.account_circle),
//           contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 15),
//           hintText: 'User Name',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

//     final textfileld = 
//         Container(
//           alignment: Alignment.centerLeft,
//           child: Text("TypeUser",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Colors.grey),),
//         );       

//     final typeTeacherfileld = 
//        Container(
//           alignment: Alignment.centerLeft,
//           child: RadioListTile(value: 'teacher', groupValue: typeUser, onChanged: (value){},
//           title: Text("Teacher",style: TextStyle(fontSize: 16),),          ),
//        );

//        final typeStudentfileld = 
//        Container(
//           alignment: Alignment.centerLeft,
//           child: RadioListTile(value: 'student', groupValue: typeUser, onChanged: (value){},
//           title: Text("Student",style: TextStyle(fontSize: 16),),
//           ),
//        );

//     final emailField = TextFormField(
//       autofocus: false,
//       controller: emailEditingController,
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return ('Please Enter Your Email');
//         }
//         if (!RegExp("^[a-zA-Z0-9+_.-]+@[dpu]+.[a-z]").hasMatch(value)){
//           return ("Please Enter a valid email");
//         }
//         return null;
//       },
//       onSaved: (value) {
//         emailEditingController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.mail),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Email',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

//     final passwordfield = TextFormField(
//       autofocus: false,
//       controller: passwordEditingController,
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
//       onSaved: (value) {
//         passwordEditingController.text = value!;
//       },
//       textInputAction: TextInputAction.next,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.vpn_key),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Password',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
//     );

//     final confirmpasswordfield = TextFormField(
//       autofocus: false,
//       controller: confirmEditingController,
//       obscureText: true,
//       validator: (value) {
//         if(confirmEditingController.text != passwordEditingController.text) {
//           return "Password don't match";
//         }
//         return null;
//       },
//       onSaved: (value) {
//         confirmEditingController.text = value!;
//       },
//       textInputAction: TextInputAction.done,
//       decoration: InputDecoration(
//           prefixIcon: Icon(Icons.vpn_key),
//           contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
//           hintText: 'Confirm Password',
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
//           signUp(emailEditingController.text,passwordEditingController.text);
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
//                       SizedBox(
//                         height: 200,
//                         child: Image.asset(
//                           'assets/logo.png',
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       userNamefileld,
//                       SizedBox(
//                         height: 20,
//                       ),
//                       textfileld,
//                       SizedBox(
//                         height: 10,
//                       ),
//                       typeTeacherfileld,
                      
//                       typeStudentfileld,
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
//                       confirmpasswordfield,
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
//   void signUp(String email, String password) async {
//     if(_formKey.currentState!.validate()) {
//       await _auth.createUserWithEmailAndPassword(email: email, password: password)
//       .then((value) => {
//         postDetailsToFirestore()
//       }).catchError((e) {
//         Fluttertoast.showToast(msg: e!.message);
//       }
//       );
//     }

//   }
//   postDetailsToFirestore() async {

//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     User? user = _auth.currentUser;

//     UserTModel userTModel = UserTModel(email: '', usernameT: '', uid: '');

//     userTModel.email = user!.email!;
//     userTModel.uid = user.uid;
//     userTModel.usernameT = userNameEditingController.text;

//     await firebaseFirestore
//     .collection("users")
//     .doc(user.uid)
//     .set(userTModel.toMap());
//   Fluttertoast.showToast(msg: "Account created successfully : )");

//   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()),
//    (route) => false);

//   }
// }