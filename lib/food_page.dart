import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FoodPage extends StatelessWidget {
  FoodPage({Key? key}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _launchMap(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch the map.')),
      );
    }
  }

  void _openUploadForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodUploadForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Donation', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.red, size: 40),
            onPressed: () => _openUploadForm(context),
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
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('food_donations').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            }
            final foodDetails = snapshot.data?.docs ?? [];

            return ListView.builder(
              itemCount: foodDetails.length,
              itemBuilder: (context, index) {
                final item = foodDetails[index].data() as Map<String, dynamic>;
                return Card(
                  color: Colors.black,
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User: ${item['username']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Food Type: ${item['foodType']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone: ${item['phoneNumber']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Quantity: ${item['quantity']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Pickup Time: ${item['pickupTime']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Container Required: ${item['containerRequired']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Location: ${item['location']}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () => _launchMap(context, item['locationUrl']),
                          icon: const Icon(Icons.map, color: Colors.white),
                          label: const Text('View Map', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}



class FoodUploadForm extends StatefulWidget {
  @override
  _FoodUploadFormState createState() => _FoodUploadFormState();
}

class _FoodUploadFormState extends State<FoodUploadForm> {
  final _formKey = GlobalKey<FormState>();
  String? _foodType;
  String? _containerRequirement;
  String _username = '';
  String _phoneNumber = '';
  String _location = '';
  String _locationUrl = '';
  String _quantity = '';
  String _pickupTime = '';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _firestore.collection('food_donations').add({
        'username': _username,
        'foodType': _foodType,
        'phoneNumber': _phoneNumber,
        'location': _location,
        'locationUrl': _locationUrl,
        'quantity': _quantity,
        'pickupTime': _pickupTime,
        'containerRequired': _containerRequirement,
      }).then((value) {
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Upload Food Donation', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _username = value,
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                onChanged: (value) => _phoneNumber = value,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _location = value,
                validator: (value) => value!.isEmpty ? 'Please enter a location' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Location URL',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _locationUrl = value,
                validator: (value) => value!.isEmpty ? 'Please enter a location URL' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _quantity = value,
                validator: (value) => value!.isEmpty ? 'Please enter a quantity' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Pickup Time',
                  labelStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (value) => _pickupTime = value,
                validator: (value) => value!.isEmpty ? 'Please enter a pickup time' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
  value: _foodType,
  decoration: const InputDecoration(
    labelText: 'Food Type',
    labelStyle: TextStyle(color: Colors.white),
    filled: true,
    fillColor: Colors.black,
  ),
  items: ['Veg', 'Non veg'].map((foodType) {
    return DropdownMenuItem(
      value: foodType,
      child: Text(
        foodType,
        style: TextStyle(color: Colors.white), // Ensure the text color is white
      ),
    );
  }).toList(),
  onChanged: (value) => setState(() {
    _foodType = value;
  }),
  validator: (value) => value == null ? 'Please select a food type' : null,
  dropdownColor: Colors.black, // Make the dropdown background black
),

              const SizedBox(height: 10),
             DropdownButtonFormField<String>(
  value: _containerRequirement,
  decoration: const InputDecoration(
    labelText: 'Container Required',
    labelStyle: TextStyle(color: Colors.white),
    filled: true,
    fillColor: Colors.black,
  ),
  items: ['Yes', 'No'].map((container) {
    return DropdownMenuItem(
      value: container,
      child: Text(
        container,
        style: TextStyle(color: Colors.white), // Ensure the text color is white
      ),
    );
  }).toList(),
  onChanged: (value) => setState(() {
    _containerRequirement = value;
  }),
  validator: (value) => value == null ? 'Please select container requirement' : null,
  dropdownColor: Colors.black, // Set the dropdown background to black
),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
