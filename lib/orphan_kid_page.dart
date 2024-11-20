// import 'package:flutter/material.dart';
// import 'OrphanageDetailsPage.dart';

// class OrphanKidPage extends StatefulWidget {
//   OrphanKidPage({Key? key}) : super(key: key);

//   @override
//   _OrphanKidPageState createState() => _OrphanKidPageState();
// }

// class _OrphanKidPageState extends State<OrphanKidPage> {
//   // Sample list of orphanages with added details
//   final List<Map<String, String>> orphanages = [
//     {
//       'name': 'Hope Orphanage',
//       'image': 'assets/orphan(3).png',
//       'mapLink': 'https://maps.app.goo.gl/twqQFjCe76iJ1zvcA',
//       'description': 'A safe haven for children in need of love and care.',
//       'contact': '123-456-7890',
//       'childrenDetails': 'Currently housing 25 children aged 5-15 years.',
//     },
//     {
//       'name': 'Care Orphanage',
//       'image': 'assets/orphan(4).png',
//       'mapLink': 'https://maps.app.goo.gl/twqQFjCe76iJ1zvcA',
//       'description': 'Providing education and shelter for underprivileged children.',
//       'contact': '098-765-4321',
//       'childrenDetails': 'Currently housing 30 children aged 6-14 years.',
//     },
//     {
//       'name': 'Holy Orphanage',
//       'image': 'assets/kid.jpg',
//       'mapLink': 'https://maps.app.goo.gl/twqQFjCe76iJ1zvcA',
//       'description': 'Providing education and shelter for underprivileged children.',
//       'contact': '098-765-4321',
//       'childrenDetails': 'Currently housing 30 children aged 6-14 years.',
//     },
//     {
//       'name': 'Mother Orphanage',
//       'image': 'assets/kid6.jpg',
//       'mapLink': 'https://maps.app.goo.gl/twqQFjCe76iJ1zvcA',
//       'description': 'Providing education and shelter for underprivileged children.',
//       'contact': '098-765-4321',
//       'childrenDetails': 'Currently housing 30 children aged 6-14 years.',
//     },
//     // Add more orphanages as needed
//   ];

//   // Filtered list of orphanages based on the search query
//   List<Map<String, String>> filteredOrphanages = [];
//   String searchQuery = '';

//   @override
//   void initState() {
//     super.initState();
//     // Initialize filtered orphanages with the full list
//     filteredOrphanages = orphanages;
//   }

//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//       // Filter the orphanages based on the search query
//       filteredOrphanages = orphanages
//           .where((orphanage) =>
//               orphanage['name']!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Orphan Kids',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.black,
//       ),
//       body: Container(
//         color: Colors.black,
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             // Search bar
//             TextField(
//               onChanged: updateSearchQuery,
//               style: const TextStyle(color: Colors.black),
//               decoration: InputDecoration(
//                 hintText: 'Search for an orphanages...',
//                 hintStyle: TextStyle(color: Colors.black),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             // List of orphanages
//             Expanded(
//               child: filteredOrphanages.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: filteredOrphanages.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             // Navigate to the details page
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => OrphanageDetailsPage(
//                                   name: filteredOrphanages[index]['name']!,
//                                   image: filteredOrphanages[index]['image']!,
//                                   mapLink: filteredOrphanages[index]['mapLink']!,
//                                   description:
//                                       filteredOrphanages[index]['description']!,
//                                   contact: filteredOrphanages[index]['contact']!,
//                                   childrenDetails:
//                                       filteredOrphanages[index]['childrenDetails']!,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.all(10),
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[800],
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 filteredOrphanages[index]['name']!,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     )
//                   : Center(
//                       child: Text(
//                         'No orphanages found',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class OrphanKidPage extends StatefulWidget {
  OrphanKidPage({Key? key}) : super(key: key);

  @override
  _OrphanKidPageState createState() => _OrphanKidPageState();
}

class _OrphanKidPageState extends State<OrphanKidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Orphan Kids',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0, // Removes any shadow
        automaticallyImplyLeading: false, // Removes any back button or icon
      ),
      body: Center(
        child: Text(
          'Our services are not available temporarily',
          textAlign: TextAlign.center, // Ensures the text is centered
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
