import 'package:flutter/material.dart';

class FriendsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // White back arrow
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Friends',
          style: TextStyle(
            color: Colors.white, // White text for the title
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/orphan(3).png'),
              ),
              title: Text(
                'Friend 1',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Action when tapping on Friend 1
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/orphan(3).png'),
              ),
              title: Text(
                'Friend 2',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                // Action when tapping on Friend 2
              },
            ),
            // Add more friends here
          ],
        ),
      ),
    );
  }
}
