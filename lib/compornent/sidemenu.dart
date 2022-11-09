import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';
import '../config/size_config.dart';

class sidemenu extends StatelessWidget {
  const sidemenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHight,
        color: Colors.deepPurple,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 100,
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/logo.png'),
                ),
              ),
              IconButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              } ,
              icon: Icon(Icons.home,size: 35,),
              iconSize: 20,
              padding: EdgeInsets.symmetric(vertical: 20.0),
               ),
              IconButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser()));
              } ,
              icon: Icon(Icons.person,size: 35,),
              iconSize: 20,
              padding: EdgeInsets.symmetric(vertical: 20.0),
               ),
              IconButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
              } ,
              icon: Icon(Icons.logout_outlined,size: 35,),
              iconSize: 20,
              padding: EdgeInsets.symmetric(vertical: 20.0),
               ),
            ],
          ),
        ),
      ),
    );
  }
}