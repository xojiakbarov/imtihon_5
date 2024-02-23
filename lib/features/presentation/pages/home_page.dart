import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  // Future<String> _getUserName() async {
  //   final user = await _auth.currentUser;
  //   if (user != null) {
  //     return user.displayName;
  //   }
  //   return null;
  // }
  
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil"),

      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        child: _user != null
            ? ListTile(
          leading: _user!.photoURL != null
              ? Image.network(
            _user!.photoURL!,
            fit: BoxFit.cover,
          )
              : Icon(Icons.person),
          title: Text(
            _user!.displayName ?? "No Name",
            style: TextStyle(
              color: Color(0xFF001444),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            _user!.email ?? "No Email",
            style: TextStyle(
              color: Color(0xFF8C97AB),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
            : ListTile(
          leading: Icon(Icons.person),
          title: Text(
            "No Name",
            style: TextStyle(
              color: Color(0xFF001444),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            "No email",
            style: TextStyle(
              color: Color(0xFF8C97AB),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}