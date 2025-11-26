// import 'package:flutter/material.dart';
// import 'package:clerk_flutter/clerk_flutter.dart' as clerk;
// import 'package:clerk_auth/clerk_auth.dart' as auth;
// import 'package:fuse/Pages/signin.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final clerk.ClerkAuthState _auth;
//   auth.User? _user;
//   bool _authInitialized = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_authInitialized) {
//       _auth = clerk.ClerkAuth.of(context);
//       _user = _auth.user;
//       _auth.addListener(_updateUser);
//       _authInitialized = true;
//     }
//   }

//   void _updateUser() {
//     if (!mounted) return;
//     setState(() {
//       _user = _auth.user;
//     });
//   }

//   Future<void> _handleSignOut() async {
//     try {
//       await _auth.signOut();
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text("Signed out successfully!"),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//       Future.delayed(Duration(seconds: 2), () {
//         if (_user == null) {
//           Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (context) => Signin()),
//             (route) => false,
//           );
//         }
//       });
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Error signing out: $e"),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = _user;

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text("Home"),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurpleAccent,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: user == null
//               ? const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator(),
//                     SizedBox(height: 20),
//                     Text("Signing Out..."),
//                   ],
//                 )
//               : Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // 👤 User avatar (optional)
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.deepPurpleAccent,
//                       child: Text(
//                         user.firstName != null && user.firstName!.isNotEmpty
//                             ? user.firstName![0].toUpperCase()
//                             : "?",
//                         style: const TextStyle(
//                           fontSize: 36,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // 📨 User info
//                     Text(
//                       user.email ?? "No email found",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     if (user.firstName != null || user.lastName != null)
//                       Text(
//                         "${user.firstName ?? ''} ${user.lastName ?? ''}".trim(),
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey,
//                         ),
//                       ),

//                     const SizedBox(height: 40),

//                     // 🚪 Sign out button
//                     ElevatedButton.icon(
//                       onPressed: _handleSignOut,
//                       icon: const Icon(Icons.logout),
//                       label: const Text("Sign Out"),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurpleAccent,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 14,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     if (_authInitialized) {
//       _auth.removeListener(_updateUser);
//       _authInitialized = false;
//     }
//     super.dispose();
//   }
// }
