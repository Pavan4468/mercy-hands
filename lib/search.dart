import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  // Firebase Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Dummy data list for UI rendering
  List<Map<String, dynamic>> users = [];

  // Holds the search query, selected blood group, and location
  String searchQuery = '';
  String? selectedBloodGroup;
  String? selectedLocation;

  // Blood groups and locations to filter
  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-', 'All'];
  final List<String> locations = ['Bangalore', 'Chennai', 'Mumbai', 'Delhi', 'Pune', 'Kolkata'];

  @override
  void initState() {
    super.initState();
    _fetchUsersFromFirestore();
  }

  // Fetch data from Firestore
  Future<void> _fetchUsersFromFirestore() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('bloodDonations').get();
      List<Map<String, dynamic>> userList = [];
      snapshot.docs.forEach((doc) {
        userList.add(doc.data() as Map<String, dynamic>);
      });

      setState(() {
        users = userList;
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter the users based on the search query, blood group, and location
    List<Map<String, dynamic>> filteredUsers = users.where((user) {
      bool matchesSearchQuery = user['username']!.toLowerCase().contains(searchQuery.toLowerCase());
      bool matchesBloodGroup = selectedBloodGroup == null || selectedBloodGroup == 'All' || user['bloodGroup'] == selectedBloodGroup;
      bool matchesLocation = selectedLocation == null || user['city'] == selectedLocation;
      return matchesSearchQuery && matchesBloodGroup && matchesLocation;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Search Donor',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.black,
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 10, spreadRadius: 2),
                ],
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search user...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Blood group filter with horizontal scroll
            Row(
              children: [
                // Filter icon for blood group and location
                IconButton(
                  icon: Icon(Icons.filter_list, color: Colors.white),
                  onPressed: () {
                    _showFilterDialog(context);
                  },
                ),
                Text('Filter', style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: 10),
                // Scrollable blood group filter buttons (row-wise)
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: bloodGroups.map((bloodGroup) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              bloodGroup,
                              style: TextStyle(color: Colors.white),
                            ),
                            selected: selectedBloodGroup == bloodGroup,
                            backgroundColor: Colors.grey[600]!,
                            selectedColor: Colors.red,
                            onSelected: (selected) {
                              setState(() {
                                selectedBloodGroup = selected ? bloodGroup : null;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // Display users (filtered or all users by default)
            Expanded(
              child: filteredUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Card(
                          color: Colors.grey[850],
                          margin: EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 30,
                              child: Icon(Icons.person, color: Colors.white,size: 50,), // Placeholder profile icon
                            ),
                            title: Text(
                              user['username']!,
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            subtitle: Text(
                              '${user['bloodGroup']} - ${user['city']}',
                              style: TextStyle(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.all(15),
                            onTap: () {
                              _showUserDetails(user);
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No users found',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show filter dialog for selecting blood group and location
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('Filter by Blood Group and Location', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Blood Group:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                // Blood group options as row-wise buttons, including 'All'
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: bloodGroups.map((bloodGroup) {
                    return ChoiceChip(
                      label: Text(bloodGroup, style: TextStyle(color: Colors.white)),
                      selected: selectedBloodGroup == bloodGroup,
                      backgroundColor: Colors.red[600]!,
                      selectedColor: Colors.red[800]!,
                      onSelected: (selected) {
                        setState(() {
                          selectedBloodGroup = selected ? bloodGroup : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Text('Location:', style: TextStyle(color: Colors.white)),
                SizedBox(height: 10),
                // Location options as row-wise buttons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: locations.map((location) {
                    return ChoiceChip(
                      label: Text(location, style: TextStyle(color: Colors.white)),
                      selected: selectedLocation == location,
                      backgroundColor: Colors.grey[600]!,
                      selectedColor: Colors.red[800]!,
                      onSelected: (selected) {
                        setState(() {
                          selectedLocation = selected ? location : null;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedBloodGroup = null;
                  selectedLocation = null;
                });
                Navigator.pop(context);
              },
              child: Text('Clear Filters', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Apply', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Show detailed user info in a dialog or new screen
  void _showUserDetails(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text(user['username']!, style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blood Group: ${user['bloodGroup']}', style: TextStyle(color: Colors.white)),
              Text('City: ${user['city']}', style: TextStyle(color: Colors.white)),
              Text('Contact: ${user['contact']}', style: TextStyle(color: Colors.white)),
              Text('Date of Birth: ${user['dob']}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Text('Additional Info:', style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text(user['details'] ?? 'No details available', style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
