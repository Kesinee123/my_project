class UserDetials {
  String? displayName;
  String? email;
  String? photoURL;

  // 
  UserDetials({this.displayName, this.email, this.photoURL});

  //
  UserDetials.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    email = json["email"];
    photoURL = json["photoURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["displayName"] = this.displayName;
    data["email"] = this.email;
    data["photoURL"] = this.photoURL;

    return data;
  }
  
}