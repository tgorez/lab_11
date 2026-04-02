import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constant/colors.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

Future<Post> fetchPost() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return Post.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to fetch post');
  }
}

class HomePage extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  const HomePage({
    super.key,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Post> postFuture;

  @override
  void initState() {
    super.initState();
    postFuture = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Name: ${widget.name}"),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Email: ${widget.email}"),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text("Phone: ${widget.phone}"),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<Post>(
              future: postFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Error loading post: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final post = snapshot.data!;
                  return Card(
                    color: Colors.grey.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Post from API:", style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text("Title: ${post.title}"),
                          const SizedBox(height: 4),
                          Text("Body: ${post.body}"),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}