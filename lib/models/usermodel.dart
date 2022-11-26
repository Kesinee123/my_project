// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class User {
  late final String uid;
  late final String email;
  final String photoUrl;
  late final String firstName;
  late final String lastName;
  late final String password;
  late final String confirmpassword;


  User({
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.confirmpassword,
  });

  factory User.fromMap(map) {
    return User(
      uid: map['uid'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      password: map['password'],
      confirmpassword: map['confirmpassword'],
    );
  }

   Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'confirmpassword': confirmpassword,
    };
  }

 
}
