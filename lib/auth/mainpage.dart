import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator_app/auth/authpage.dart';
import 'package:translator_app/views/authethication/register/createprofile.dart';
import 'package:translator_app/views/bottomnavbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //   final String _uid = _user!.uid;
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshotdata) {
                    if (snapshotdata.hasData) {
                      if (snapshotdata.data!.exists) {
                        return const BottomNavbar();
                      } else {
                        return const CreateProfile();
                      }
                    } else {
                      return const Wait();
                    }
                  });
            } else {
              return const AuthPage();
            }
          }),
    );
  }
}

class Wait extends StatelessWidget {
  const Wait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff151716),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Please wait...',
                  style:
                      GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ));
  }
}
