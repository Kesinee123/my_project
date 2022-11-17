import 'package:flutter/material.dart';

class NamesPage extends StatefulWidget{
  const NamesPage({Key? key}) : super(key: key);
  @override
  State<NamesPage> createState() => _NamesPageState();
}

class _NamesPageState extends State<NamesPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 114, 253),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                        padding: EdgeInsets.all(30),
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
                                    Icons.person_sharp,
                                  ),
                                  hintText: "Enter Your Name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 251, 204, 64)
                        ),
                        child: Center(
                          child: Text("Start", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        ),
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
}