import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:my_project/compornent/quizDetailList.dart';
import 'package:my_project/config/responsive.dart';
import 'package:my_project/config/size_config.dart';
import 'package:my_project/compornent/sidemenu.dart';
import 'package:my_project/views/views_teachers/create/create_quizs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  // final String path;

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final isDialOpen = ValueNotifier(false);
  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

   bool shouldShowNotification = false;

  FlutterLocalNotificationsPlugin? notifications;

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

  notifications = FlutterLocalNotificationsPlugin();
  await notifications!.initialize(initializationSettings);
}

Future<void> showNotification() async {
  if (notifications == null) {
    await initializeNotifications();
  }

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      // 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

  const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

  await notifications!.show(
      0, // id ของแจ้งเตือน
    'แจ้งเตือน', // หัวข้อของแจ้งเตือน
    'ปัญหาที่คุณแจ้งได้รับการแก้ไขเสร็จสิ้นแล้ว', // เนื้อหาของแจ้งเตือน
    platformChannelSpecifics,
  );
}

@override
  void initState() {
    super.initState();
    Firebase.initializeApp().then((_) {
      FirebaseFirestore.instance
          .collection('problum')
          .doc('QBLew22zp9yA5Bsys85G')
          .get()
          .then((documentSnapshot) {
        final data = documentSnapshot.data()!;
        data['status'] == 'false' ? showNotification() : Text('');
      });
    });
  }



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
                ),
                SpeedDialChild(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.edit),
                  label: 'แจ้งเตือน',
                  onTap: () => showNotification(),
                  // showToast('...Create Quiz'),
                )
              ],
            ),
         drawer: sidemenu(),
         appBar: AppBar(
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
              ))
            // IconButton(onPressed: (){},
            // icon: Icon(Icons.help))
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

