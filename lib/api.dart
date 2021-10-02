import 'dart:convert';

import 'package:flutter_json_api/comment_model.dart';
import 'package:flutter_json_api/post_model.dart';
import 'package:flutter_json_api/user_model.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUser() async {
  http.Response response =
      await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
  if (response.statusCode == 200) {
    List<User> users = [];
    for (Map<String, dynamic> i in jsonDecode(response.body)) {
      users.add(User.fromJson(i));
    }
    return users;
  } else {
    throw Exception("Failed tp load user");
  }
}

Future<List<Post>> fetchPosts(int id) async {
  http.Response response = await http
      .get(Uri.parse("https://jsonplaceholder.typicode.com/users/$id/posts"));
  if (response.statusCode == 200) {
    List<Post> posts = [];
    for (Map<String, dynamic> i in jsonDecode(response.body)) {
      posts.add(Post.fromJson(i));
    }
    return posts;
  } else {
    throw Exception("Failed tp load user");
  }
}

Future<List<Comment>> fetchComments(
  int pid,
) async {
  http.Response response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts/$pid/comments"));
  if (response.statusCode == 200) {
    List<Comment> comments = [];
    for (Map<String, dynamic> i in jsonDecode(response.body)) {
      comments.add(Comment.fromJson(i));
    }
    return comments;
  } else {
    throw Exception("Failed tp load user");
  }
}

Future<Post> createPost(Post post) async {
  http.Response response = await http.post(
    Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    body: jsonEncode(post),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 201) {
    print(response.body);
  } else {
    throw Exception("Failed t0 create Post");
  }
}

Future<User> createUser(User user) async {
  http.Response response = await http.post(
    Uri.parse("https://jsonplaceholder.typicode.com/users"),
    body: jsonEncode(user),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 201) {
    print(response.body);
  } else {
    throw Exception("Failed t0 create user");
  }
}

Future<Comment> createComment(Comment comment) async {
  http.Response response = await http.post(
    Uri.parse("https://jsonplaceholder.typicode.com/comments"),
    body: jsonEncode(comment),
    headers: {
      'Content-type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 201) {
    print(response.body);
  } else {
    throw Exception("Failed t0 create user");
  }
}

Future<void> deleteUser(int id) async {
  http.Response response = await http
      .delete(Uri.parse("https://jsonplaceholder.typicode.com/users/$id"));
  if (response.statusCode == 200) {
    print("user deleted!");
  } else {
    throw Exception("Failed to delete user");
  }
}

Future<void> deletePost(int id) async {
  http.Response response = await http
      .delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));
  if (response.statusCode == 200) {
    print("Post deleted!");
  } else {
    throw Exception("Failed to delete post");
  }
}

Future<void> deleteComment(int id) async {
  http.Response response = await http
      .delete(Uri.parse("https://jsonplaceholder.typicode.com/comments/$id"));
  if (response.statusCode == 200) {
    print("comment deleted!");
  } else {
    throw Exception("Failed to delete comment");
  }
}
