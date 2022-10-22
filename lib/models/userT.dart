class UserTModel {
  String uid;
  String email;
  String usernameT;

  UserTModel({required this.email, required this.usernameT, required this.uid});

  // data from server
  factory UserTModel.fromMap(map) {
    return UserTModel(
      email: map['email'], usernameT: map['usernameT'], uid: map['uid']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid' : uid,
      'email' : email,
      'usernameT' : usernameT,
    };
  }
}