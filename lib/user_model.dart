class User {
  int id;
  String name;
  String username;
  String email;

  User({this.id, this.email, this.name, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        username: json['username']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'username': username};
  }
}
