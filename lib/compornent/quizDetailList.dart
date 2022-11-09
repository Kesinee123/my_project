import 'package:flutter/material.dart';
import 'package:my_project/data/menu_items.dart';
import 'package:my_project/models/menu_item.dart';
import 'package:my_project/views/views_teachers/details.dart';

class QuizDetailList extends StatelessWidget {
  const QuizDetailList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   
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
          ),
          
        ],
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