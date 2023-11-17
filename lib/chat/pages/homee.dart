import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/chat/pages/chat_page.dart';
import 'package:movies/screens/bottom_nav_bar.dart';

class Homme extends StatefulWidget {
  const Homme({super.key});

  @override
  State<Homme> createState() => _HommeState();
}

class _HommeState extends State<Homme> {
  //sign user out

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Page'), actions: [
        IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout))
      ]),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 123, 5, 5),
                Color.fromARGB(255, 60, 2, 2)
              ], // Change colors as needed
            ),
          ),
          child: _buildUserList()),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('loading...');
        }
        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    //display users
    return Center(
        child: Padding(
     padding: EdgeInsets.symmetric(
  horizontal: MediaQuery.of(context).size.width / 3,
  vertical: MediaQuery.of(context).size.height / 3,
),

      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0),
          child: Text('Choose someone you want to chat!',style: TextStyle(
             color: Colors.white,
             fontSize: 25,
              fontWeight: FontWeight.bold,
              // You can add more styling properties here
            ),),
        ),
       Card(
  color: Colors.white, // Set the background color of the Card
  child: ListTile(
    title: Text(data['email']),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            receiverUserEmail: data['email'],
            receiverID: data['uid'],
          ),
        ),
      );
    },
  ),
)

      ]),
    ));
  }
}
