import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class ShowListName extends StatefulWidget {
  const ShowListName({super.key});


  @override
  State<ShowListName> createState() => _ShowListNameState();
}

class _ShowListNameState extends State<ShowListName> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange , Colors.orange]),
            ),
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Colors.orange,
                          ),
                          boxShadow: [
                            BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            blurRadius: 8,
                            spreadRadius: 3
                          ),
                          ] ,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(5),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/avatan.jpg'),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Pailin Thongloy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                          SizedBox(height: 20,),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Teacher', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      
                        ],
                      ),
                      
                    ],
                  )
                ],
              ),
               ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.grey.shade200,
              child: ListView(
                padding: EdgeInsets.only(top: 30),
                children: [
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          openExit();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 50 ,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('END' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Text('Student List' , style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),)),
                  SizedBox(height: 20,),
                  buildStudentLists(1 , Icons.face_sharp , 'UserName 1' , 200),
                  SizedBox(height: 20,),
                  buildStudentLists(2 , Icons.face_sharp , 'UserName 2' , 100),
                  SizedBox(height: 20,),
                  buildStudentLists(3 , Icons.face_sharp , 'UserName 3' , 50),
                  SizedBox(height: 20,),
                  buildStudentLists(4 , Icons.face_sharp , 'UserName 4' , 20),
                ],
              ),
            ) )
        ],
      ),
    );
  }

  Container buildStudentLists( int number ,IconData icon , String title , int amount) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange,
                  ),
                  height: 85,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                      height: 30 ,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Text('$number' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                          Row(
                            children: [
                              Icon(icon, color: Colors.white,),
                              SizedBox(width: 10,),
                              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            child: Text('$amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),))
                        ],
                      ),
                     
                      Stack(
                        children: [
                          Container(
                           margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey.shade200,
                            ),
                          ),
                          Container(
                             margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 5,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.green
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
  }
  Future openExit() => showDialog(
    context: context, builder: (context) => AlertDialog(
      backgroundColor: Colors.blueGrey,
      content: Container(
        alignment: Alignment.center,
        height: 100,
        width: 280,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100 ,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Download' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: (){
                              
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 100 ,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Again' , style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                  
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
           
          ],
        ),
      ),
        actions: [
         Container(
        
          width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red
          ),
          onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text('Exit'))),
        ],
    ) );
}
