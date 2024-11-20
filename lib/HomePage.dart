import 'package:flutter/material.dart';
import 'upload_page.dart';
import 'profile_page.dart';
import 'food_page.dart';
import 'home_page_content.dart';
import 'decoration.dart'; // Import the HomePage widget (DonationApp)

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Keep track of the selected index

  // Updated _pages list to include DonationApp (HomePage)
  final List<Widget> _pages = [
    DonationApp(),    // DonationApp (HomePage)
    HomePageContent(), // Home Page Content
    UploadPage(),      // Upload Page
    FoodPage(),        // Food Page
    ProfilePage(),     // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Home icon
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bloodtype_outlined, color: Colors.red, size: 30.0), // Blood icon
            label: 'Blood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_file), // Upload icon
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood), // Food icon
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person), // Profile icon
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex, // Highlight the current index
        onTap: _onItemTapped, // Handle tap events
        selectedItemColor: Colors.white, // Set selected icon color to white
        unselectedItemColor: Colors.grey, // Set unselected icon color to grey
        backgroundColor: Colors.black, // Set background color of the nav bar to black
        type: BottomNavigationBarType.fixed, // Keep the item fixed
      ),
    );
  }
}


