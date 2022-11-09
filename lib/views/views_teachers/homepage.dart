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
                  label: 'Create Quiz',
                  onTap: () => 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz())),
                  // showToast('...Create Quiz'),
                )
              ],
            ),
         key: _drawerkey,
         drawer: SizedBox(width: 100 , child: sidemenu(),),
         appBar: !Responsive.isDestop(context) ? AppBar (
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: (){
            _drawerkey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.black,)),
          actions: [
            AppBarActionItems(), 
          ],
          ): PreferredSize(child: SizedBox(), preferredSize: Size.zero),
          body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(Responsive.isDestop(context))
            Expanded(flex: 1,child: sidemenu()
            ),
            Expanded(
                flex: 10,
                child: Container(
                  width: double.infinity,
                  height: SizeConfig.screenHight,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      children: [
                        if(Responsive.isDestop(context))
                      AppBarActionItems(),
                      SizedBox(height: 20,),
                      QuizDetailList(),
                      
                    ]),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}

