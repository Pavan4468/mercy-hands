import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MaterialApp(
    home: HomePageContent(),
  ));
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  bool _isIconVisible = true;
  bool _isRed = false;

  // List to store user data from Firestore
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isRed = !_isRed;
      });
    });
    _startBlinking();
    _fetchUsers(); // Fetch users data from Firestore
  }

  void _startBlinking() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _isIconVisible = !_isIconVisible;
      });
    });
  }

  // Fetch data from Firestore
  Future<void> _fetchUsers() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bloodDonations').get();
      setState(() {
        users = snapshot.docs.map((doc) {
          return User(
            doc['username'] ?? '', // Added username
            doc['area'] ?? '',
            doc['bloodGroup'] ?? '',
            (doc['dob'] as Timestamp).toDate().toString(), // Convert timestamp to string
            doc['city'] ?? '',
            doc['mapsUrl'] ?? '',
            doc['contact'] ?? '', // Added contact field
          );
        }).toList();
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Merciful Hands',
          style: TextStyle(
            color: _isRed ? Colors.white : Colors.red,
            fontStyle: FontStyle.italic,
            fontSize: 25,
          ),
        ),
        actions: [
          if (_isIconVisible)
            IconButton(
              icon: Icon(Icons.bloodtype_outlined, color: Colors.red, size: 30.0),
              onPressed: () {},
            ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white, size: 30.0),
            onPressed: () {
              // Navigate to the SearchTab screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchTab()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red[800]!,
              Colors.black,
              Colors.grey[850]!,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.5, 0.7, 1],
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: users.isEmpty
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserCard(user: users[index]);
                },
              ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  Future<void> _launchMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchPhone(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_circle, color: Colors.white, size: 30), // User icon before username
              SizedBox(width: 10), // Space between icon and username
              Text(
                user.username, // Display username here
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(
                'Location: ${user.city}',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_city, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Text(
                'Area: ${user.area}', // Display area here
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.white, size: 20), // Icon for contact
              SizedBox(width: 5),
              Text(
                'Contact: ${user.contact}', // Display contact here
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.bloodtype, color: Colors.red, size: 20),
              SizedBox(width: 5),
              Text(
                'Blood Group Needed: ${user.bloodGroup}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.cake, color: Colors.white, size: 20),
              SizedBox(width: 5),
              Flexible( // Wrap the DOB text with Flexible widget to prevent overflow
                child: Text(
                  'Date of Birth: ${user.dob}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _launchMap(user.mapsUrl),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'Find Blood Donation Center',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10),
          
        ],
      ),
    );
  }
}

class User {
  final String username;
  final String area;
  final String bloodGroup;
  final String dob;
  final String city;
  final String mapsUrl;
  final String contact;

  User(this.username, this.area, this.bloodGroup, this.dob, this.city, this.mapsUrl, this.contact);
}
