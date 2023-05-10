import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Score1 extends StatefulWidget {
  const Score1({super.key});

  @override
  State<Score1> createState() => _Score1State();
}

class _Score1State extends State<Score1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
                color: Color.fromARGB(255, 151, 114, 253),
                borderRadius: BorderRadius.circular(10),),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('ยินด้วยที่ทำแบบทดสอบจนจบ' ,style: TextStyle(
                  color: Colors.white ,
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Text('คะแนนที่ได้ : ',style: TextStyle(
                  color: Colors.white ,
                  fontSize: 20 ,
                  fontWeight: FontWeight.bold),),
                SizedBox(height: 50,),
                Text('10' , style: TextStyle(
                  color: Colors.amber,
                  fontSize: 80,
                  fontWeight: FontWeight.bold
                ),) ,
                SizedBox(height: 50,),
                ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.amber)
                ),
                onPressed: (){

                },
                child: Text('ดูคะแนนของเพื่อนทั้งหมด' , style: TextStyle(
                  fontSize: 15,
                  
                ),))
              ],
            ),
        // Padding(
        //   padding: const EdgeInsets.all(40),
        //   child: Container(
        //     height: 500,
        //     width: 500,
        //     decoration: BoxDecoration(
        //         color: Colors.deepPurple,
        //         borderRadius: BorderRadius.circular(10),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withOpacity(0.5),
        //             spreadRadius: 5,
        //             blurRadius: 7,
        //             offset: const Offset(0, 3), // changes position of shadow
        //           ),
        //         ]),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children:  const [
        //         Text('ยินด้วยที่ทำแบบทดสอบจนจบ' ,style: TextStyle(
        //           color: Colors.white ,
        //           fontSize: 20 ,
        //           fontWeight: FontWeight.bold),),
        //         SizedBox(height: 20,),
        //         Text('คะแนนที่ได้ : ',style: TextStyle(
        //           color: Colors.white ,
        //           fontSize: 20 ,
        //           fontWeight: FontWeight.bold),),
        //         SizedBox(height: 50,),
        //         Text('10' , style: TextStyle(
        //           color: Colors.amber,
        //           fontSize: 50,
        //           fontWeight: FontWeight.bold
        //         ),) 
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
