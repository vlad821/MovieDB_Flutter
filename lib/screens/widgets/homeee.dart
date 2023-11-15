import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homee extends StatelessWidget {
  const Homee({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        actions:[
          IconButton(
            onPressed: signUserOut,
            icon:Icon(Icons.logout),
          )
        ]
        ),
        body: Center(child: Text('Logged IN!'),)
        );
  }
}
