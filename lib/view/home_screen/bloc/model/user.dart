class User {
  String? email;
  String? id;
  String? accessToken;

  User({this.email, this.id, this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "id": id,
      };
}
