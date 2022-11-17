import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/namePage.dart';

class LetPage extends StatefulWidget {
  const LetPage({Key? key}) : super(key: key);
  @override
  State<LetPage> createState() => _LetPageState();
}

class _LetPageState extends State<LetPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
       backgroundColor: Color.fromARGB(255, 151, 114, 253),
       body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(onPressed: (){
                  signOut(context);
                }, icon: Icon(Icons.exit_to_app))),
              SizedBox(height: 60,),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Quizzz", style: TextStyle(color: Colors.white, fontSize: 40),),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    children: <Widget> [
                      SizedBox(height: 60,),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Color.fromARGB(255, 176, 97, 255),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )],
                        ),
                        child: Column(
                          children: <Widget> [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.code_sharp,
                                  ),
                                  hintText: " Enter Your Code",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Column(
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.push(context,MaterialPageRoute(builder: (context) => NamesPage()));
                          //   } ,
                          // ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 251, 204, 64)
                            ),
                            child: Center(
                              child: Text("Join", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
       ),
    );
  }
  Future<void> signOut(BuildContext context) async {
       await FirebaseAuth.instance.signOut();
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
    }
}