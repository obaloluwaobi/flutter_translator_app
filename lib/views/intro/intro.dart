// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:translator_app/auth/mainpage.dart';

// import 'package:translator_app/views/authethication/register/create_acct.dart';

// class IntroPage extends StatelessWidget {
//   final VoidCallback showLogin;
//   IntroPage({super.key, required this.showLogin});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff151716),
//       body: Center(
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Lottie.asset('assets/lottie/intro.json'),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
//               child: Text(
//                 'Break down languages barriers translate, text-to-speech & speech to text',
//                 style: TextStyle(color: Colors.white, fontSize: 17),
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const AuthLogin()));
//                     },
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(fontSize: 25, color: Colors.black),
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 30.0,
//               ),
//               child: SizedBox(
//                 height: 50,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                     onPressed: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => CreateAcctPage(
//                                 showLogin: showLogin,
//                               )));
//                     },
//                     child: const Text(
//                       'Register',
//                       style: TextStyle(fontSize: 25, color: Colors.black),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
