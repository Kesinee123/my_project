import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_project/compornent/appBarActionItems.dart';
import 'package:my_project/compornent/quizDetailList.dart';
import 'package:my_project/config/responsive.dart';
import 'package:my_project/config/size_config.dart';
import 'package:my_project/compornent/sidemenu.dart';
import 'package:my_project/views/views_teachers/create_quizs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final isDialOpen = ValueNotifier(false);
  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                  label: 'สร้างแบบทดสอบ',
                  onTap: () => 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz())),
                  // showToast('...Create Quiz'),
                )
              ],
            ),
         drawer: sidemenu(),
         appBar: AppBar(
          actions: [
            IconButton(onPressed: (){},
            icon: Icon(Icons.help))
          ],
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text('แบบทดสอบ'),
        ),
          body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if(Responsive.isDestop(context))
            // Expanded(flex: 2,child: sidemenu()
            // ),
            Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHight,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child:
                      QuizDetailList(),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}

