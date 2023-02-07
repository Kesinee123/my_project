// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class Ranking_Student extends StatefulWidget {
  const Ranking_Student({super.key});

  @override
  State<Ranking_Student> createState() => _Ranking_StudentState();
}

class _Ranking_StudentState extends State<Ranking_Student> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.purple,
        body: Container(
          height: 1000,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors:[ Colors.deepPurple , Colors.purple])
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                      onPressed: (){
                        showSheet(context);
                      },
                    child: Text('END')),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .4,
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3 - 90,
                    top: 20,
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text('2' , style: TextStyle(fontSize: 18 , color: Colors.white),),
                        Icon(Icons.arrow_drop_up, size: 40, color: Colors.yellow,),
                        costomCircleAvatan(
                          size: Size.fromHeight(120),
                          image: 'assets/avatan.jpg',
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3 + 90,
                    top: 20,
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text('3', style: TextStyle(fontSize: 18 , color: Colors.white),),
                        Icon(Icons.arrow_drop_down, size: 40, color: Colors.white,),
                        costomCircleAvatan(
                          size: Size.fromHeight(120),
                          image: 'assets/avatan.jpg',
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3,
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text('1', style: TextStyle(fontSize: 18, color: Colors.white),),
                        Image.asset('assets/crown.png' , height: 40,),
                        costomCircleAvatan(
                          size: Size.fromHeight(120),
                          image: 'assets/avatan.jpg',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // SizedBox(height: 20,),
              // Divider(),
              buildRanking(1, 'ชื่อ', 'คะแนน'),
              buildRanking(2, 'ชื่อ', 'คะแนน'),
              buildRanking(3, 'ชื่อ', 'คะแนน'),
              buildRanking(4, 'ชื่อ', 'คะแนน'),
              buildRanking(5, 'ชื่อ', 'คะแนน'),
            ],
          ),
        ),
      ),
    );
  }

  // ลำดับและชื่อนักเรียน
  Container buildRanking(int number, String name, String point) {
    return Container(
      // margin: EdgeInsets.all(5),
      child: ListTile(
        leading: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$number', style: TextStyle(fontWeight: FontWeight.bold),),
            Icon(
              Icons.arrow_drop_up,
              color: Colors.white,
            )
          ],
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white.withOpacity(.2),
          ),
          padding: EdgeInsets.only(right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/avatan.jpg'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(name , style: TextStyle(color: Colors.white),),
              Spacer(),
              Text(point, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
  showSheet (BuildContext context) {
    showModalBottomSheet(context: context,
    builder: (context){
      return Padding(
            padding: EdgeInsets.only(
                // top: 20,
                // left: 20,
                // right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    child: ListTile(
                      leading: Icon(Icons.download, color: Colors.white, size: 20,),
                      title: Text('ดาวน์โหลด', style: TextStyle(fontSize: 18, color: Colors.white ,fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app, color: Colors.white, size: 20,),
                      title: Text('ออกจากแบบทดสอบ', style: TextStyle(fontSize: 18, color: Colors.white ,fontWeight: FontWeight.bold),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
    }

class costomCircleAvatan extends StatelessWidget {

  final Size size;
  final String image;
  
  const costomCircleAvatan({
    Key? key,
    required this.size,
    required this.image
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 40,),
        Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            width: 5,
                            color: Colors.orange,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple,
                              blurRadius: 10,
                              offset: Offset(0, 0)
                            )
                          ],
                          image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(height: 10,),
                    Text('ชื่อ', style: TextStyle(fontSize: 16 , color: Colors.white),),
                    Text('คะแนน', style: TextStyle(fontSize: 16 , color: Colors.white , fontWeight: FontWeight.bold),),
      ],
    );
  }
}
