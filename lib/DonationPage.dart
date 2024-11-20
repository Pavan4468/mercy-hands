import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donate Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
         iconTheme: const IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Donation Amount',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Amount (e.g. 500)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Payment methods in two columns using GridView
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2.5, // Aspect ratio for more button space
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle credit card payment
                  },
                  icon: Icon(Icons.credit_card),
                  label: const Text('Credit Card'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007BFF),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle PayPal payment
                  },
                  icon: Icon(Icons.account_balance_wallet),
                  label: const Text('PayPal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28A745),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle UPI payment
                  },
                  icon: Icon(Icons.qr_code),
                  label: const Text('UPI'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA500),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Google Pay payment
                  },
                  icon: Icon(Icons.payment),
                  label: const Text('Google Pay'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF34A853),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Debit Card payment
                  },
                  icon: Icon(Icons.card_membership),
                  label: const Text('Debit Card'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A1B9A),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle Net Banking payment
                  },
                  icon: Icon(Icons.account_balance),
                  label: const Text('Net Banking'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle donation submission
                },
                child: const Text(
                  'Submit Donation',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 50.0,
                  ),
                  backgroundColor: const Color(0xFF003F63),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
