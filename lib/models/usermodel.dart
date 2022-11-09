// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

@immutable
class User {
  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  User({
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.displayName,
  });

  User copyWith({
    String? uid,
    String? email,
    String? photoUrl,
    String? displayName,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'displayName': displayName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
      displayName: map['displayName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, photoUrl: $photoUrl, displayName: $displayName)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.email == email &&
      other.photoUrl == photoUrl &&
      other.displayName == displayName;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      photoUrl.hashCode ^
      displayName.hashCode;
  }
}
