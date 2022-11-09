import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/add_quizs.dart';

class FormCreateQuiz extends StatelessWidget {
  const FormCreateQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
    child: Container(
      color: Colors.white,
      height: 530,
      width: 530,
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.deepPurple),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    // Expanded(
                                    //   child: _image == null
                                    //       ? Center(
                                    //           child:
                                    //               Text("No image selected"))
                                    //       : Image.file(_image!),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.yellow),
                  onPressed: () {},
                  child: Text(
                    'เพิ่มรูปภาพ',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    "ชื่อแบบทดสอบ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: TextFormField(
                    onChanged: (value) {},
                    validator: ((val) => val!.isEmpty
                        ? "โปรดกรอกชื่อแบบทดสอบ"
                        : null),
                    // decoration: InputDecoration(hintText: "Quiz Title"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: Text(
                    "ชื่อวิชาของแบบทดสอบ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  child: TextFormField(
                    onChanged: (value) {},
                    validator: ((val) => val!.isEmpty
                        ? "โปรดกรอกชื่อวิชาของแบบทดสอบ"
                        : null),
                    // decoration: InputDecoration(hintText: "Quiz Subject"),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Material(
                          elevation: 0,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey,
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            // minWidth: MediaQuery.of(context).size.width,
                            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AddQuiz())),
                            child: Text(
                              'Cancle',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Material(
                          elevation: 0,
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.purple,
                          child: MaterialButton(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            // minWidth: MediaQuery.of(context).size.width,
                            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AddQuiz())),
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            ]
        )
      )
                )
    );
  }
}
