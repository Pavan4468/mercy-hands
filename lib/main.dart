import 'package:flutter/material.dart';
import 'signin_page.dart'; // Import the SignInPage
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merciful Hands',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Start a timer to navigate to the SignInPage after 5 seconds
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'All Glory to God',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Set the text color to red
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/book.jpg', // Replace with your image asset path
              height: 200, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Text(
              'MERCY HANDS',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set the text color to white
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Galatians 5:13–14',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Set the text color to red
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '“For you, brothers, were called to freedom. Only do not use your freedom as an opportunity for the flesh, but through love serve one another. For the whole law is fulfilled in one word: “You shall love your neighbor as yourself.”',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white, // Set the text color to white
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
