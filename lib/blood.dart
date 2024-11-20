import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodPage extends StatelessWidget {
  // Sample user data
  final List<User> users = [
    User('Pavan Kumar', 'assets/orphan(3).png', 'O+', ['assets/blood.jpg', 'assets/bllod2.jpg', 'assets/recipt.webp']),
    User('Rajesh Singh', 'assets/orphan(3).png', 'A+', ['assets/kid.jpg', 'assets/kid2.jpeg']),
    User('Sneha Sharma', 'assets/orphan(3).png', 'B-', ['assets/kid2.jpeg', 'assets/kid3.jpg']),
    User('Amit Kumar', 'assets/orphan(3).png', 'AB+', ['assets/kid.jpg']),
    User('Neha Gupta', 'assets/orphan(3).png', 'O-', ['assets/kid3.jpg']),
    User('Ravi Verma', 'assets/orphan(3).png', 'A-', ['assets/kid2.jpeg']),
    User('Sita Patel', 'assets/orphan(3).png', 'B+', ['assets/kid.jpg', 'assets/kid3.jpg']),
    User('Vikram Das', 'assets/orphan(3).png', 'AB-', ['assets/kid2.jpeg']),
    User('Meena Khanna', 'assets/orphan(3).png', 'O+', ['assets/kid.jpg']),
    User('Tarun Sethi', 'assets/orphan(3).png', 'A+', ['assets/kid3.jpg']),
  ];

  // Method to launch map URL
  void _launchMap() async {
    const String url = 'https://maps.app.goo.gl/twqQFjCe76iJ1zvcA';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blood Donation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.grey[850],
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return UserCard(user: users[index], onLaunchMap: _launchMap);
          },
        ),
      ),
    );
  }
}

class UserCard extends StatefulWidget {
  final User user;
  final VoidCallback onLaunchMap;

  UserCard({required this.user, required this.onLaunchMap});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  int _currentIndex = 0;

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
          // User info section
          Row(
            children: [
              CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(widget.user.image),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.user.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Blood group needs section
          Text(
            'Blood Group Needed: ${widget.user.bloodGroup}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Please donate if you have this blood type.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          // Image carousel section using PageView
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PageView.builder(
                  itemCount: widget.user.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullImageScreen(imagePath: widget.user.images[index]),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            widget.user.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // Dots indicator
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.user.images.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index ? Colors.red : Colors.white,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Call to action button
          ElevatedButton(
            onPressed: widget.onLaunchMap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // Button background color
            ),
            child: Text(
              'Find Blood Donation Center',
              style: TextStyle(color: Colors.white), // Button text color
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  final String name;
  final String image;
  final String bloodGroup;
  final List<String> images;

  User(this.name, this.image, this.bloodGroup, [this.images = const []]);
}
class FullImageScreen extends StatelessWidget {
  final String imagePath;

  const FullImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
