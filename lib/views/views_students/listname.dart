import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/ranking_Student.dart';

class ListName extends StatefulWidget {
  const ListName({super.key});

  @override
  State<ListName> createState() => _ListNameState();
}

class _ListNameState extends State<ListName> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.purple,
        body: Container(
          height: 1000,
          color: Colors.grey[300],
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(colors:[ Colors.deepPurple , Colors.purple])
          // ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(onPressed: (){},
                    icon: const Icon(Icons.exit_to_app))
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .4,
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3 - 100,
                    top: 20,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '2',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_drop_up,
                          size: 40,
                          color: Colors.yellow,
                        ),
                        Container(
                          height: 140,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                ),
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 3 + 130,
                    top: 20,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '3',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                          color: Colors.white,
                        ),
                        Container(
                          height: 140,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                ),
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  '0',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2.7,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '1',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        Image.asset(
                          'assets/crown.png',
                          height: 40,
                        ),
                        Container(
                          height: 140,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!),
                                ),
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  '10',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 151, 114, 253),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'ลำดับ',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'ชื่อ-นามสกุล',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'คะแนน',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              buildRanking(1, FirebaseAuth.instance.currentUser!.displayName!, '10'),
              buildRanking(2, 'ชื่อ', '0'),
              buildRanking(3, 'ชื่อ', '0'),
              buildRanking(4, 'ชื่อ', '0'),
            ],
          ),
        ),
      ),
    );
  }

  // ลำดับและชื่อนักเรียน
  Container buildRanking(int number, String name, String point) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20 , top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$number',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.arrow_drop_up,
                  color: Colors.black,
                )
              ],
            ),
          ),
          
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/avatan.jpg'),
              ),
              const SizedBox(width: 10,),
              Text(
                name,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsets.only(right: 20 , top: 5),
            child: Text(
              point,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black , fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}