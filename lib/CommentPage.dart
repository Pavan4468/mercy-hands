import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final List<String> comments = []; // List to store comments
  final TextEditingController _controller = TextEditingController(); // Controller for the input field

  void _addComment() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        comments.add(_controller.text); // Add comment to the list
        _controller.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Comment', // AppBar title
          style: TextStyle(
            color: Colors.white, // Set text color to blue
             // Set text to italic
          ),),
          iconTheme: const IconThemeData(
    color: Colors.white, // Set the back arrow color to white
  ),
        backgroundColor: Colors.black, // AppBar color
      ),
      body: Container(
        color: Colors.black, // Background color for the page
        padding: EdgeInsets.all(16.0), // Padding around the container
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0), // Margin for comments
                    padding: EdgeInsets.all(10.0), // Padding inside each comment
                    decoration: BoxDecoration(
                      color: Colors.grey[850], // Comment background color
                      borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    ),
                    child: Text(
                      comments[index],
                      style: TextStyle(
                        color: Colors.white, // Comment text color
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Controller for the input field
                    decoration: InputDecoration(
                      hintText: 'Enter your comment',
                      hintStyle: TextStyle(color: Colors.white54), // Hint text color
                      filled: true,
                      fillColor: Colors.grey[800], // Input field background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0), // Rounded corners
                        borderSide: BorderSide.none, // Remove border
                      ),
                    ),
                    style: TextStyle(color: Colors.white), // Input text color
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.white), // Send button
                  onPressed: _addComment, // Call method to add comment
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false, // Hide debug banner
    home: CommentPage(),
  ));
}
