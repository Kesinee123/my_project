// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:my_project/views/signin.dart';

// class firstPage extends StatefulWidget {
//   const firstPage({super.key});

//   @override
//   State<firstPage> createState() => _firstPageState();
// }

// class _firstPageState extends State<firstPage> {
//   @override
//   Widget build(BuildContext context) {
//     return initWidget();
//   }


//   Widget initWidget(){
//     return Scaffold(
//       body: Stack(children: [
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple, Colors.purple] ,
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter
//                ),
//           ),
          
//         ),
//         Center(
//           child: Container(
//             margin: EdgeInsets.all(40),
//             child: Image.asset('assets/logo.png',fit: BoxFit.contain,),
//           ),
//         ),
        
//         Center(
//           child: Container(
//             height: 40,
//             width: 100,
//             margin: EdgeInsets.fromLTRB(0, 300, 0, 0),
//             child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               shadowColor: Colors.black,
//                     primary: Colors.white),
//             onPressed: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
//             },
//             child: Text("Start",style: TextStyle(fontSize: 20,color: Colors.purple))),
//           ),
//         )
//       ]),
//     );
//   }
// }