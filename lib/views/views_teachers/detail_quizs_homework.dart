import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class detial_Quizs_homepage extends StatefulWidget {
  const detial_Quizs_homepage({super.key});

  @override
  State<detial_Quizs_homepage> createState() => _detial_Quizs_homepageState();
}

class _detial_Quizs_homepageState extends State<detial_Quizs_homepage> {
   @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,title: Text('HomeWork'),),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Container(
                    margin: EdgeInsets.only(top: size.height * 0.4),
                    height: 600,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Container(
                      margin: EdgeInsets.all(24),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 320,
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: [
                              Text(
                                "โจทย์ข้อที่ 1",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    "โจทย์ : ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("โจทย์คำถาม"),
                                  SizedBox(
                                    height: 8,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "คำตอบ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 20, color: Colors.green),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("คำตอบที่ 1"),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 20, color: Colors.red),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("คำตอบที่ 2"),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 20, color: Colors.red),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("คำตอบที่ 3"),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle,
                                                size: 20, color: Colors.red),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("คำตอบที่ 4"),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    // Text(
                                    //         "${snapshot.data!.docs[index].id}"
                                    //       ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ชื่อของแบบทดสอบ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "ชื่อวิชาของแบบทดสอบ",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("วันที่กำหนดส่ง : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              SizedBox(width: 10,),
                              Text('22/10/2565',style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text("เวลากำหนดส่ง : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              SizedBox(width: 10,),
                              Text(' 20:00 ',style: TextStyle(color: Colors.white),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text('Share Link',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                color: Colors.white,
                                height: 40,
                                width: 150,
                                child: Text('www.google.com',style: TextStyle(color: Colors.black),)),
                                SizedBox(width: 10,),
                                TextButton(onPressed: (){},
                                child: Text('คัดลอกลิงค์',style: TextStyle(color: Colors.yellow),))
                            ],
                          )
                        ]),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}