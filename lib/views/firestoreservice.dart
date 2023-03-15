import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 
  CollectionReference quizs = FirebaseFirestore.instance.collection('quizs');

}