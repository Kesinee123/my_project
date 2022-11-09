
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class ProfileUser extends StatefulWidget {
  ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,),
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 34),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "MyProfile",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 250,
                    width: 800,
                    child: LayoutBuilder(builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxHeight;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("UserName", style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                                IconButton(onPressed: (){},
                                                icon: Icon(FontAwesomeIcons.pen,
                                                    color: Colors.blue,
                                                  ),)
                                              ],
                                            ),
                                            SizedBox(height: 10,),
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("Email : ",
                                                    style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                                                  ],
                                                ),
                                                Text(
                                                'pailin@dpu.ac.th',
                                                style: TextStyle(color: Colors.black,fontSize: 20),)
                                              ],
                                            ),
                                            
                                          ],
                                        ),
                                     
                                  ),
                              )),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage('assets/avatan.jpg')
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 150,
                            right: 0,
                            bottom: 10,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow,
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add_a_photo), onPressed: () {  },)
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
