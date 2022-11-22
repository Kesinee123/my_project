import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/data/menu_items.dart';
import 'package:my_project/models/menu_item.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:my_project/views/views_teachers/editCreate_quizs.dart';

class QuizDetailList extends StatefulWidget {
  QuizDetailList({
    super.key,
  });

  @override
  State<QuizDetailList> createState() => _QuizDetailListState();
}

class _QuizDetailListState extends State<QuizDetailList> {

  List<String> popList = ["แก้ไข","ลบ"];

  Future<void> _deleteQuiz(id) async{
    await FirebaseFirestore.instance.collection("quizs").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("quizs").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              final DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
               return Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurple),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details()));
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 32,
                      backgroundImage: NetworkImage(
                          "https://png.pngtree.com/png-clipart/20190117/ourlarge/pngtree-cartoon-book-notes-stationery-png-image_424364.jpg"),
                    ),
                    title: Text(documentSnapshot['quizTitle']),
                    subtitle: Text(documentSnapshot['quizSubject']),
                    trailing: PopupMenuButton(
                      onSelected: (value) {
                        if(value == "ลบ") {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('ต้องการลบแบบทดสอบหรือไม่ ??', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey
                                            ),
                                            onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text('ยกเลิก')),
                                          SizedBox(width: 50,),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red
                                            ),
                                            onPressed: (){
                                              _deleteQuiz(documentSnapshot.id);
                                            }, child: Text('ลบ'))
                                        ],
                                      )
                                    ],
                                  )),
                              );
                            });
                        }else{
                          Navigator.push(context,MaterialPageRoute(
                            builder: (context) => EditCreateQuiz()));
                        }
                      },
                      itemBuilder: (context) {
                        return popList.map((e) => PopupMenuItem(
                          value: e,
                          child: Text(e))).toList();
                      } )
                    
                  ),
                ),
              ),
              
            ],
          );
            });
        }else{
          return CircularProgressIndicator();
        }
      }
    );
  }
}

//   void onSelected(BuildContext context, MenuItem item) {
//         switch (item) {
//           case MenuItems.itemEdit: 
//             showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Text('แก้ไขโพสต์'),
//                 );
//             });
//             break;
//             case MenuItems.itemDelete: 
//             showDialog(context: context, builder: (BuildContext context) {
//                 return AlertDialog(
//                   title: Column(
//                     children: [
//                       Text('ต้องการลบแบบทดสอบหรือไม่ ??'),
//                       SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.grey
//                             ),
//                             onPressed: (){},
//                           child: Text('ยกเลิก')),
//                           SizedBox(width: 50,),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red
//                             ),
//                             onPressed: (){
                              
//                             },
//                           child: Text('ลบ'))
//                         ],
//                       ),
                      
//                     ],
//                   ),
//                 );
//             });
//         }
//       }
// }

//  PopupMenuItem<MenuItem> buildItem(MenuItem item) => 
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

// // class PopupMenu extends StatelessWidget {
// //   final List<PopupMenuEntry> menuList;
// //   final Widget? icon;
// //   const PopupMenu({Key? key, required this.menuList, this.icon}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return PopupMenuButton(
// //       itemBuilder: ((context) => menuList),
// //       icon: icon,
// //        );
// //   }
// // }