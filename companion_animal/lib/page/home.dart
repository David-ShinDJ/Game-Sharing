import 'package:flutter/material.dart';


class Post {
  final String title;
  final String content;
  final String imageUrl;
  final String userId;
  final String userName;
  final String userProfileImage;

  Post({required this.title, required this.content, required this.imageUrl, required this.userId, required this.userName, required this.userProfileImage});
}

class Database {
  static List<Post> posts = [];
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
        Center(child: Text("Home Page"),),
      ],),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Second Page"),);
  }
}
class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Third Page"),);
  }
}

