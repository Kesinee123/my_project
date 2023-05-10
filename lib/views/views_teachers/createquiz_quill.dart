// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

// class Test_quill extends StatefulWidget {
//   const Test_quill({super.key});

//   @override
//   State<Test_quill> createState() => _Test_quillState();
// }

// final _formKey = GlobalKey<FormState>();

// final quill.QuillController _controller = quill.QuillController.basic();
// final FocusNode _focusNode = FocusNode();

// String question = '';
// String option1 = '';

// class _Test_quillState extends State<Test_quill> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.deepPurple,
//       ),
//       backgroundColor: Color.fromARGB(255, 119, 86, 174),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                     color: Colors.deepPurple,
//                     // decoration: BoxDecoration(
//                     //     image: DecorationImage(
//                     //       image: ExactAssetImage("assets/dw.jpg"),
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //   ),
//                     child: Container(
//                       // width: 600,
//                       // padding: EdgeInsets.symmetric(
//                       //     vertical: 24.0),
//                       child: Center(
//                         child: Container(
//                           // padding: EdgeInsets.symmetric(horizontal: 10),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "โจทย์คำถาม",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                               SizedBox(
//                                 height: 20,
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   // borderRadius: BorderRadius.circular(10)
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     quill.QuillToolbar.basic(
//                                       controller: _controller,
//                                       toolbarIconSize: 16,
//                                       // multiRowsDisplay: false,
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Container(
//                                       height: 200,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: quill.QuillEditor.basic(
//                                           controller: _controller,
//                                           readOnly:
//                                               false, // true for view only mode
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     // ElevatedButton.icon(
//                                     //   style: ElevatedButton.styleFrom(
//                                     //       backgroundColor: Colors.yellow),
//                                     //   onPressed: () {
//                                     //     // imagePickerQuestion3();
//                                     //   },
//                                     //   label: Text(
//                                     //     "เพิ่มรูปภาพ",
//                                     //     style: TextStyle(color: Colors.black),
//                                     //   ),
//                                     //   icon: Icon(
//                                     //     Icons.add_a_photo,
//                                     //     color: Colors.black,
//                                     //   ),
//                                     // )
//                                   ],
//                                 ),
//                               ),

//                               //  Center(
//                               //   child: _imageQs3 == null
//                               //       ? null
//                               //       : Image.file(_imageQs3!)),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 24),
//                     alignment: Alignment.center,
//                     width: 800,
//                     height: 400,
//                     color: Colors.white,
//                     child: Column(children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "คำตอบ",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: 800,
//                         child: ListTile(
//                           title: TextFormField(
//                             // validator: (value) =>
//                             //     value!.isEmpty ? "กรอกคำตอบที่ถูกต้อง" : null,
//                             decoration: InputDecoration(hintText: 'คำตอบ'),
//                             onChanged: (value) {
//                               option1 = value;
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               primary: Colors.deepPurple),
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               if (option1 == "") {
//                                 //  showSnackbar(
//                                 //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
//                                 normalDialog(
//                                     context, 'โปรดกรอกคำตอบที่ถูกต้อง');
//                                 return;
//                               }
//                               // createQuestionWrite(
//                               //   question,
//                               // );
//                               showSnackbar(context, Colors.green,
//                                   "สร้างโจทย์คำถามสำเร็จ");
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //         builder: (context) => DetailsQuizs(
//                               //               quizId: widget.quizId,
//                               //               questionId: widget.questionId,
//                               //             )));
//                             }
//                           },
//                           child: Text('บันทึกโจทย์'))
//                     ]),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void showSnackbar(context, color, message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//         message,
//         style: TextStyle(fontSize: 14),
//       ),
//       backgroundColor: color,
//       duration: Duration(seconds: 5),
//     ));
//   }

//   Future<void> normalDialog(BuildContext context, String s) async {
//     showDialog(
//         context: context,
//         builder: (context) => SimpleDialog(
//               title: Text(s),
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text(
//                         'ตกลง',
//                         style: TextStyle(fontSize: 16, color: Colors.red),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ));
//   }
// }
