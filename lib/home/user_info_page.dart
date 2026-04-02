import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {

  final String name;
  final String email;
  final String phone;

  const UserInfoPage({
    super.key,
    this.name = '',
    this.email = '',
    this.phone = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Name: $name"),
            Text("Email: $email"),
            Text("Phone: $phone"),
          ],
        ),
      ),
    );
  }
}