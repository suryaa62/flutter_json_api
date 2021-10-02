import 'package:flutter/material.dart';
import 'package:flutter_json_api/api.dart';
import 'package:flutter_json_api/comment_model.dart';
import 'package:flutter_json_api/post_model.dart';
import 'package:flutter_json_api/user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo of JsonPlaceholder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Aim of this project is to help me and others learn how Api and Json Serialization works in flutter!!!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            )),
                        Text(
                            "This is website uses all the api's provided in JsonPlaceholder.com ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ))
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Resources",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "JSONPlaceholder comes with a set of 6 common resources: \n/posts 100 posts \n/comments 500 comments\n/albums 100 albums\n/photos 5000 photos\n/todos 200 todos\n/users 10 users",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      Text("\nRoutes",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                      Text(
                          "All HTTP methods are supported. You can use http or https for your requests.\nGET /posts\nGET /posts/1\nGET /posts/1/comments\nGET /comments?postId=1\nPOST /posts\nPUT /posts/1\nPATCH /posts/1\nDELETE /posts/1",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          MainBody()
        ],
      ),
    );
  }
}

enum mainBodyState {
  user,

  posts,
  comments,
}

class MainBody extends StatefulWidget {
  const MainBody({Key key}) : super(key: key);

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  String title = "Users";
  String name = "";
  int id = 0;
  int pid = 0;
  mainBodyState state = mainBodyState.user;

  Future myFuture() {
    if (state == mainBodyState.user) return fetchUser();
    if (state == mainBodyState.posts) return fetchPosts(id);
    if (state == mainBodyState.comments) return fetchComments(pid);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (state != mainBodyState.user)
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_sharp),
                        onPressed: () {
                          setState(() {
                            if (state == mainBodyState.comments) {
                              state = mainBodyState.posts;
                              title = name + "'s posts";
                            } else {
                              state = mainBodyState.user;
                              title = "Users";
                            }
                          });
                        })
                    : Container(),
                Text(title),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (state == mainBodyState.posts)
                        createPost(Post(
                            userId: id,
                            title: "my first post",
                            body: "heyaaaaa"));

                      if (state == mainBodyState.user)
                        createUser(User(
                            name: "suryakant",
                            email: "s@gmail.com",
                            username: "suryakantt"));
                      if (state == mainBodyState.comments)
                        createComment(Comment(
                            body: "lormklnjhjkjkjkjhk",
                            email: "s@gmail.com",
                            name: "suryakantt",
                            postId: pid));
                    })
              ],
            ),
          ),
          FutureBuilder(
            future: myFuture(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  width: 500,
                  height: 300,
                  child: ListView.separated(
                      itemBuilder: (context, value) {
                        if (state == mainBodyState.comments)
                          return ListTile(
                            title: Text(snapshot.data[value].email),
                            subtitle: Text(snapshot.data[value].body),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteComment(snapshot.data[value].id);
                              },
                            ),
                          );

                        if (state == mainBodyState.posts)
                          return ListTile(
                            title: Text(snapshot.data[value].title),
                            subtitle: Text(
                                snapshot.data[value].body + "\nBy " + name),
                            onTap: () {
                              setState(() {
                                pid = snapshot.data[value].id;
                                title = "Comments";
                                state = mainBodyState.comments;
                              });
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deletePost(snapshot.data[value].id);
                              },
                            ),
                          );

                        return ListTile(
                          title: Text(snapshot.data[value].name),
                          subtitle: Text(snapshot.data[value].username +
                              "\n" +
                              snapshot.data[value].email),
                          onTap: () {
                            setState(() {
                              name = snapshot.data[value].name;
                              id = snapshot.data[value].id;
                              title = name + "'s Posts";
                              state = mainBodyState.posts;
                            });
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteUser(snapshot.data[value].id);
                            },
                          ),
                        );
                      },
                      itemCount: snapshot.data.length,
                      separatorBuilder: (context, value) {
                        return Divider();
                      }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
