import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';
import 'package:my_project/views/views_teachers/chatpage.dart';
import 'package:my_project/views/views_teachers/report.dart';
import '../config/size_config.dart';

class sidemenu extends StatelessWidget {
  const sidemenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      child:  ListView(
        padding: EdgeInsets.symmetric(vertical: 50),
        children: [
          Image.asset("assets/logo.png",
          height: 150,
          ),
          SizedBox(height: 20,),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: (){} ,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.group, color: Colors.white,),
            title: Text("แบบทดสอบ", style: TextStyle(color: Colors.white),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser()));
            } ,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.account_circle, color: Colors.white,),
            title: Text("โปรไฟล์", style: TextStyle(color: Colors.white),),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReportPage()));
            } ,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.clear, color: Colors.white,),
            title: Text("แจ้งปัญหา", style: TextStyle(color: Colors.white),),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: () async{
              showDialog
              (context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("ออกจากระบบ"),
                  content: Text("ต้องการออกจากระบบหรือไม่"),
                  actions: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel, color: Colors.red,)),
                    IconButton(onPressed: () async {
                      await FirebaseAuth.instance.signOut().then((value) => 
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn())));
                    },
                    icon: Icon(Icons.exit_to_app, color: Colors.green,)),
                  ],
                );
              });
            } ,
            selected: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            leading: Icon(Icons.exit_to_app, color: Colors.white,),
            title: Text("ออกจากระบบ", style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
  // Future<void> signOut(BuildContext context) async {
  //      await FirebaseAuth.instance.signOut();
  //      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
  //   }
}