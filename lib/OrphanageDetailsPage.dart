import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'DonationPage.dart'; // Import the DonationPage

class OrphanageDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String mapLink;
  final String description;
  final String contact;
  final String childrenDetails;

  const OrphanageDetailsPage({
    Key? key,
    required this.name,
    required this.image,
    required this.mapLink,
    required this.description,
    required this.contact,
    required this.childrenDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
  title: Text(
    name,
    style: const TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.black,
  iconTheme: const IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ),
),

      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800], // Grey background
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Center(child: Image.asset(image)), // Center the image
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Description:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Contact:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contact,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Children Details:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      childrenDetails,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
             Center(
  child: ElevatedButton(
    onPressed: () async {
      final Uri url = Uri.parse(mapLink);
      print('Attempting to launch URL: $mapLink');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $mapLink';
      }
    },
    child: const Text('View Map'),
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFFFFFF), // Button color
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    ),
  ),
),

              const SizedBox(height: 10),
              Center( // Centering the Donate button
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Donation Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DonationPage()),
                    );
                  },
                  child: const Text("Donate",
    style: const TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28A745), // Changed button color
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
