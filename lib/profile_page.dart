import 'package:flutter/material.dart';
import 'AboutPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.white), // Right icon
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // User Profile Section
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
  'PAVAN',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Color(0xFFD3D3D3), // Light shining silver color
  ),
),

                    SizedBox(height: 5),
                    Text(
                      'Location: Bangalore',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            

            // Toggle Buttons for Blood Donations and Food Donations
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Blood Donations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 120,
                        color: _currentIndex == 0 ? Colors.blue : Colors.transparent,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                  child: Column(
                    children: [
                      const Text(
                        'Food Donations',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 100,
                        color: _currentIndex == 1 ? Colors.blue : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Displaying Blood or Food Donations based on the selected tab
            Expanded(
              child: _currentIndex == 0 ? _buildBloodDonationsPage() : _buildFoodDonationsPage(),
            ),
          ],
        ),
      ),
    );
  }

  // Blood Donations Page
  Widget _buildBloodDonationsPage() {
    List<Map<String, String>> bloodDonations = [
      {"title": "Blood Donation Needed", "location": "City Hospital, Bangalore", "date": "2024-11-10"},
      {"title": "Blood Required Urgently", "location": "Apollo Hospital, Chennai", "date": "2024-11-11"},
      // Add more blood donations as needed
    ];

    return ListView.builder(
      itemCount: bloodDonations.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showDetailsPopup(
            context,
            title: bloodDonations[index]["title"]!,
            details:
                "${bloodDonations[index]["location"]}\nDate: ${bloodDonations[index]["date"]}",
          ),
          child: _buildDonationContainer(
            bloodDonations[index]["title"]!,
            bloodDonations[index]["location"]!,
            bloodDonations[index]["date"]!,
          ),
        );
      },
    );
  }

  // Food Donations Page
  Widget _buildFoodDonationsPage() {
    List<Map<String, String>> foodDonations = [
      {"title": "Food for Orphanage", "location": "Happy Home, Bangalore", "date": "2024-11-12"},
      {"title": "Meal Needed for Shelter", "location": "Care Shelter, Chennai", "date": "2024-11-13"},
      // Add more food donations as needed
    ];

    return ListView.builder(
      itemCount: foodDonations.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showDetailsPopup(
            context,
            title: foodDonations[index]["title"]!,
            details:
                "${foodDonations[index]["location"]}\nDate: ${foodDonations[index]["date"]}",
          ),
          child: _buildDonationContainer(
            foodDonations[index]["title"]!,
            foodDonations[index]["location"]!,
            foodDonations[index]["date"]!,
          ),
        );
      },
    );
  }

  // Donation Container Widget
  Widget _buildDonationContainer(String title, String location, String date) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          Text(
            date,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Show details in a popup
  void _showDetailsPopup(BuildContext context, {required String title, required String details}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(title, style: const TextStyle(color: Colors.white)),
          content: Text(
            details,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
