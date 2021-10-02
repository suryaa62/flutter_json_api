class Comment {
  int id;
  String name;
  String body;
  String email;
  int postId;

  Comment({this.id, this.email, this.name, this.body, this.postId});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body'],
        postId: json['postId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'body': body,
      'postId': postId
    };
  }
}
