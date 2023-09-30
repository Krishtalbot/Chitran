// import 'package:flutter/material.dart';

// class InfoCard extends StatefulWidget {
//   const InfoCard({Key? key}) : super(key: key);

//   @override
//   _InfoCardState createState() => _InfoCardState();
// }

// class _InfoCardState extends State<InfoCard> {
//   bool _isCardVisible = false;

//   void _toggleCardVisibility() {
//     setState(() {
//       _isCardVisible = !_isCardVisible;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _toggleCardVisibility, // Toggle visibility on tap
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.5),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         margin: EdgeInsets.all(16.0),
//         padding: EdgeInsets.all(16.0),
//         child: _isCardVisible
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Info Card Title',
//                     style: TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),
//                   Text(
//                     'This is your info card content.',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ],
//               )
//             : Text(
//                 'Tap to show info card',
//                 style: TextStyle(fontSize: 16.0),
//               ),
//       ),
//     );
//   }
// }
