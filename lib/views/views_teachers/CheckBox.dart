// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class CheckboxTest extends StatefulWidget {
//   const CheckboxTest({super.key});

//   @override
//   State<CheckboxTest> createState() => _CheckboxTestState();
// }

// class _CheckboxTestState extends State<CheckboxTest> {

//   List data = ['1','2','3','4'];
//   List selectedData = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: data.map((e) {
//           return CheckboxListTile(
//             title: TextFormField(),
//             value: selectedData.indexOf(e) < 0 ? false : true,
//             onChanged: (value){
//               if(selectedData.indexOf(e) < 0 ) {
//                 setState(() {
//                   selectedData.add(e);
//                 });
//               }else{
//                 setState(() {
//                   selectedData.removeWhere((element) =>element == e);
//                 });
//               }
//               print(selectedData);
//             },
//             controlAffinity: ListTileControlAffinity.leading,
            
//             );
//         }).toList(),
//       )
//     );
//   }
// }