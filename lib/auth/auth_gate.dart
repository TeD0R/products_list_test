// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../bottom_nav_bar.dart';
// import 'login_page.dart';
//
// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return const BottomNavBar();
//         } else {
//           return const LoginPage();
//         }
//       },
//     );
//   }
// }
