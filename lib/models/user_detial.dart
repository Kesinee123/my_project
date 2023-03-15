// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class UserDetials {
//   String? displayName;
//   String? email;
//   // String? photoURL;
//   UserDetials({
//     this.displayName,
//     this.email,
//     // this.photoURL,
//   });

//   UserDetials copyWith({
//     String? displayName,
//     String? email,
//     String? photoURL,
//   }) {
//     return UserDetials(
//       displayName: displayName ?? this.displayName,
//       email: email ?? this.email,
//       // photoURL: photoURL ?? this.photoURL,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'displayName': displayName,
//       'email': email,
//       // 'photoURL': photoURL,
//     };
//   }

//   factory UserDetials.fromMap(Map<String, dynamic> map) {
//     return UserDetials(
//       displayName: map['displayName'] != null ? map['displayName'] as String : null,
//       email: map['email'] != null ? map['email'] as String : null,
//       // photoURL: map['photoURL'] != null ? map['photoURL'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserDetials.fromJson(String source) => UserDetials.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'UserDetials(displayName: $displayName, email: $email)';

//   @override
//   bool operator ==(covariant UserDetials other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.displayName == displayName &&
//       other.email == email ;
//   }

//   @override
//   int get hashCode => displayName.hashCode ^ email.hashCode;
// }
