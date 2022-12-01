import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';

class ProfileSPage extends StatefulWidget {
  const ProfileSPage({Key? key}) : super(key: key);
  @override
  State<ProfileSPage> createState() => _ProfileSPageState();
}

class _ProfileSPageState extends State<ProfileSPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
     firstNameController.text = documentSnapshot['firstName'];
      lastNameController.text = documentSnapshot['lastName'];

      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: TextField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'ชื่อจริง'),
              ),
              content: TextField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'นามสกุล'),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      final String firstName = firstNameController.text;
                      final String lastName = lastNameController.text;

                      FirebaseFirestore.instance.collection("users").doc(documentSnapshot.id).update({
                          "firstName": firstName, "lastName": lastName
                      });
                      firstNameController.text = '';
                      lastNameController.text = '';
                      Navigator.pop(context);
                    },
                    child: Text('ตกลง'))
              ],
            );
          });
    }
  }

  final currenUser = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffdee2fe),
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("uid", isEqualTo: currenUser.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(onPressed: (){Navigator.pop(context);},
                                      icon: Icon(Icons.arrow_back)),
                                      IconButton(
                                        icon: Icon(Icons.exit_to_app),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                  title: Text("ออกจากระบบ"),
                                                  content: Text(
                                                      "ต้องการออกจากระบบหรือไม่"),
                                                  actions: [
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                        )),
                                                    IconButton(
                                                        onPressed: () {
                                                          signOut(context);
                                                        },
                                                        icon: Icon(
                                                          Icons.exit_to_app,
                                                          color: Colors.green,
                                                        )),
                                                  ],
                                                );
                                              });
                                        },
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    margin: const EdgeInsets.only(
                                      top: 50,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(2, 2),
                                          blurRadius: 10,
                                        ),
                                      ],
                                      image: const DecorationImage(
                                        image: AssetImage("assets/profile.png"),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    documentSnapshot['type'],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 24, right: 24, bottom: 200),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Profile",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Name",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        documentSnapshot[
                                                            'firstName'],
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        documentSnapshot[
                                                            'lastName'],
                                                        style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 120,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    _update(documentSnapshot);
                                                  },
                                                  icon: Icon(Icons.edit))
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.email,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 24,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Email",
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  Text(
                                                    documentSnapshot['email'],
                                                    style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                      });
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
  }
}
