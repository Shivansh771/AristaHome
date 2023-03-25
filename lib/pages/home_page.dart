import 'package:arista/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final user=FirebaseAuth.instance.currentUser;
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user?.email as String),
        backgroundColor: Colors.deepPurple,
        actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
      ),
    );
  }
}
