import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'HomePage.dart';
import 'signin_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController altPhoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? bloodGroup;
  String? state;

  Future<void> registerUser() async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'blood_group': bloodGroup,
        'phone_number': phoneController.text,
        'alt_phone_number': altPhoneController.text,
        'address': addressController.text,
        'state': state,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                'Create Account',
                style: TextStyle(color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(controller: usernameController, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Username')),
              SizedBox(height: 16),
              TextField(controller: emailController, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Email')),
              SizedBox(height: 16),
              TextField(controller: passwordController, obscureText: true, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Password')),
              SizedBox(height: 16),
              _buildDropdownField('Select Blood Group', ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'], (value) => setState(() => bloodGroup = value)),
              SizedBox(height: 16),
              TextField(controller: phoneController, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Phone Number')),
              SizedBox(height: 16),
              TextField(controller: altPhoneController, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Alternate Phone Number')),
              SizedBox(height: 16),
              TextField(controller: addressController, maxLines: 2, style: TextStyle(color: Colors.white), decoration: _inputDecoration('Address')),
              SizedBox(height: 16),
              _buildDropdownField('Select State', ['Andhra Pradesh', 'Karnataka', 'Maharashtra', 'Tamil Nadu', 'Delhi'], (value) => setState(() => state = value)),
              SizedBox(height: 16),
              ElevatedButton(onPressed: registerUser, child: Text('Sign Up', style: TextStyle(fontSize: 18))),
              SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage())),
                child: Text('I have an account already. Sign In', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[900],
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  Widget _buildDropdownField(String hint, List<String> items, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[900],
      hint: Text(hint, style: TextStyle(color: Colors.grey)),
      style: TextStyle(color: Colors.white),
      decoration: _inputDecoration(''),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
    );
  }
}
