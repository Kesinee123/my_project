// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:my_project/models/menu_item.dart';
// import 'package:my_project/views/data/menu_items.dart';
// import 'package:my_project/views/views_teachers/add_quizs.dart';
// import 'package:my_project/views/views_teachers/create_questions.dart';
// import 'package:my_project/views/views_teachers/details.dart';
// import 'package:my_project/views/views_teachers/homepage.dart';

// class AddQuestion extends StatefulWidget {
  
//   const AddQuestion({super.key, required this.quizId});
//   final String quizId;

//   @override
//   State<AddQuestion> createState() => _AddQuestionState();
// }

// class _AddQuestionState extends State<AddQuestion> {
//   final isDialOpen = ValueNotifier(false);

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async{
//         if (isDialOpen.value){
//           isDialOpen.value = false;

//           return false;
//         }else{
//           return true;
//         }
//       },
//       child: Scaffold(
//           appBar: AppBar(backgroundColor: Colors.deepPurple , title: Text('AddQuestion'),),
//           backgroundColor: Colors.deepPurple,
//           floatingActionButton: SpeedDial(
//               animatedIcon: AnimatedIcons.menu_close,
//               backgroundColor: Colors.purple,
//               overlayColor: Colors.white,
//               overlayOpacity: 0.4,
//               spacing: 12,
//               // closeManually: true,
//               openCloseDial: isDialOpen,
//               children: [
//                 SpeedDialChild(
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.edit),
//                   label: 'Add Quiz',
//                   onTap: () {},
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuiz())),
//                   // showToast('...Create Quiz'),
//                 )
//               ],
//             ),
//         body:SafeArea(
//           child: Center(
//             child: Container(
//               margin: EdgeInsets.all(20),
//                   width: 800,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                         primary: Colors.grey),
                            
//                             onPressed: (){
//                               Navigator.pushReplacement(context,
//                         MaterialPageRoute(builder: ((context) => HomePage())));
//                             },
//                           child: Text('Cancel')),
//                           SizedBox(width: 20, height: 100,),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                         primary: Colors.yellow),
//                             onPressed: (){
//                         //       Navigator.pushReplacement(context,
//                         // MaterialPageRoute(builder: ((context) => Details())));
//                             },
//                           child: Text('Save',style: TextStyle(color: Colors.black),))
//                         ],
//                       ),
//                       Container(
//                             margin: EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.white
//                             ),
//                               child: Container(
//                                 margin: EdgeInsets.all(30),
//                                 height: 320,
//                                     alignment: Alignment.centerLeft,
//                                     child: Column(
//                                       children: [
                                       
//                                             Text("????????????????????????????????? 1",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                          
//                                         SizedBox(height: 20),
//                                         Row(
//                                           children: [
//                                             Text("??????????????? : ", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//                                             SizedBox(width: 10,),
//                                         Text(
//                                           "??????????????????????????????"
//                                         ),
//                                         SizedBox(
//                                           height: 8,
//                                         ),
//                                           ],
//                                         ),
//                                         SizedBox(height: 20,),
//                                         Container(
//                                           alignment: Alignment.centerLeft,
//                                           child: Column(
//                                             children: [
//                                               Container(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Text("???????????????",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
//                                               SizedBox(height: 20,),
//                                             Container(
//                                               alignment: Alignment.centerLeft,
//                                                 child: 
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.circle, size: 20 ,color: Colors.green),
//                                                       SizedBox(width: 10,),
//                                                       Text("???????????????????????? 1" ),
//                                                     ],
//                                                   )
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             Container(
//                                               alignment: Alignment.centerLeft,
//                                                 child: 
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.circle, size: 20 ,color: Colors.red),
//                                                       SizedBox(width: 10,),
//                                                       Text("???????????????????????? 2" ),
//                                                     ],
//                                                   )
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                            Container(
//                                               alignment: Alignment.centerLeft,
//                                                 child: 
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.circle, size: 20 ,color: Colors.red),
//                                                       SizedBox(width: 10,),
//                                                       Text("???????????????????????? 3" ),
//                                                     ],
//                                                   )
//                                             ),
//                                             SizedBox(
//                                               height: 15,
//                                             ),
//                                             Container(
//                                               alignment: Alignment.centerLeft,
//                                                 child: 
//                                                   Row(
//                                                     children: [
//                                                       Icon(Icons.circle, size: 20 ,color: Colors.red),
//                                                       SizedBox(width: 10,),
//                                                       Text("???????????????????????? 4" ),
//                                                     ],
//                                                   )
//                                             ),
//                                             SizedBox(
//                                               height: 10,
//                                             ),
//                                             // Text(
//                                             //         "${snapshot.data!.docs[index].id}"
//                                             //       ),
//                                             ],
//                                           ),
//                                           ),
//                                         Container(
//                                           alignment: Alignment.centerRight,
//                                           child: IconButton(onPressed: (){
                                              
//                                           },
//                                           icon: PopupMenuButton<MenuItem>(
//                                             onSelected: (item) => onSelected(context, item) ,
//                                             itemBuilder: (context) =>[
//                                               ...MenuItems.itemsFirst.map(buildItem).toList(),
//                                             ],
//                                         )
//                                           )
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                       ),
//                     ],
//                   )
//             ),
//           ),
//         )
//       )
//         );
//   }
//        PopupMenuItem<MenuItem> buildItem(MenuItem item) => 
//   PopupMenuItem<MenuItem>(
//     value: item,
//     child: Row(
//     children: [
//       Icon(item.icon, color: Colors.black,size: 20),
//       const SizedBox(width: 12,),
//       Text(item.text),
//     ]
//   )
//       );

//       void onSelected(BuildContext context, MenuItem item) {
//         switch (item) {
//           case MenuItems.itemEdit: 
//             showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('??????????????????????????????'),
//                 );
//             });
//             break;
//             case MenuItems.itemDelete: 
//             showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('?????????????????????'),
//                 );
//             });
//         }
//       }
// }

// Future showToast(String message) async {
//   await Fluttertoast.cancel();

//   Fluttertoast.showToast(msg: message, fontSize: 18);
// }          

       