import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_project/data/menu_items.dart';
import 'package:my_project/models/menu_item.dart';
import 'package:my_project/models/quiz.dart';
import 'package:my_project/views/MyHeaderDrawer/MyHeaderDrawer.dart';
import 'package:my_project/views/views_teachers/create_quizs.dart';
import 'package:my_project/views/views_teachers/details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isDialOpen = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if (isDialOpen.value){
          isDialOpen.value = false;

          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
          drawer: MyHeaderDrawer(),
          appBar: AppBar(backgroundColor: Colors.deepPurple),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.purple,
            overlayColor: Colors.white,
            overlayOpacity: 0.4,
            spacing: 12,
            // closeManually: true,
            openCloseDial: isDialOpen,
            children: [
              SpeedDialChild(
                backgroundColor: Colors.white,
                child: Icon(Icons.edit),
                label: 'Create Quiz',
                onTap: () => 
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz())),
                // showToast('...Create Quiz'),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: Container(
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
                title: Text("ชื่อของแบบทดสอบ"),
                subtitle: Text("วิชาของแบบทดสอบ"),
                trailing: PopupMenuButton<MenuItem>(
                  onSelected: (item) => onSelected(context, item) ,
                  itemBuilder: (context) =>[
                    ...MenuItems.itemsFirst.map(buildItem).toList(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => 
  PopupMenuItem<MenuItem>(
    value: item,
    child: Row(
    children: [
      Icon(item.icon, color: Colors.black,size: 20),
      const SizedBox(width: 12,),
      Text(item.text),
    ]
  )
      );

      void onSelected(BuildContext context, MenuItem item) {
        switch (item) {
          case MenuItems.itemEdit: 
            showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('แก้ไขโพสต์'),
                );
            });
            break;
            case MenuItems.itemDelete: 
            showDialog(context: context, builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ลบโพสต์'),
                );
            });
        }
      }
}

Future showToast(String message) async {
  await Fluttertoast.cancel();

  Fluttertoast.showToast(msg: message, fontSize: 18);
}
