// import 'package:flutter/material.dart';

// class Testing {

//   AppBar(
//         elevation: 15.0,
//         backgroundColor: Colors.blueGrey[900].withOpacity(_opacity),
//         shadowColor: Colors.black,
//         title: Text(widget.title),
//         actions: [
//           if (userRoles.contains('admin'))
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.0),
//               child: FlatButton(
//                 onPressed: () => Navigator.pushNamed(context, '/add_photo'),
//                 child: Text(
//                   ADD_PHOTO,
//                   style: textStyleParagraph2.copyWith(color: Colors.white),
//                 ),
//               ).moveUpOnHover,
//             ),
//           if (userRoles.contains('admin'))
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10.0),
//               child: FlatButton(
//                 child: Text(
//                   REGISTER,
//                   style: textStyleParagraph2.copyWith(color: Colors.white),
//                 ),
//                 onPressed: () => showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Register();
//                     }),
//               ).moveUpOnHover,
//             ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.0),
//             child: FlatButton(
//               child: Text(
//                 SIGN_IN,
//                 style: textStyleParagraph2.copyWith(color: Colors.white),
//               ),
//               onPressed: () => showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return SignIn();
//                   }),
//             ).moveUpOnHover,
//           ),
//         ],
//         bottom: _buildTabBar(),);
// }