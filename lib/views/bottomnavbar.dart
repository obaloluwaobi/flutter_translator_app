import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:translator_app/views/history/history.dart';
import 'package:translator_app/views/home/homepage.dart';
import 'package:translator_app/views/profile/profile.dart';
import 'package:translator_app/views/tts/texttospeech.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedtab = 0;
  void navBottomBar(int index) {
    setState(() {
      selectedtab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: BottomNavigationBar(
        onTabChange: (index) {
          navBottomBar(index);
        },
      ),
      backgroundColor: const Color(0xff151716),
      body: _pages[selectedtab],
    );
  }

  final List<Widget> _pages = [
    const HomePage(),
    const TexttoSpeech(),
    const HistoryPage(),
    const ProfilePage(),
  ];
}

class BottomNavigationBar extends StatelessWidget {
  final Function(int)? onTabChange;
  const BottomNavigationBar({
    required this.onTabChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black),
      child: GNav(
          tabMargin: const EdgeInsets.symmetric(vertical: 10),
          tabBackgroundColor: const Color(0xff121212),
          textStyle: GoogleFonts.poppins(color: Colors.white),
          style: GnavStyle.google,
          backgroundColor: Colors.transparent,
          mainAxisAlignment: MainAxisAlignment.center,
          gap: 7,
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            GButton(
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(20),
              iconActiveColor: Colors.white,
              icon: Icons.home_outlined,
              iconColor: Colors.white,
              text: 'Home',
            ),
            GButton(
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(20),
              iconActiveColor: Colors.white,
              icon: Icons.mic,
            //  text: 'T',
              iconColor: Colors.white,
            ),
            GButton(
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(20),
              iconActiveColor: Colors.white,
              icon: Icons.history_outlined,
              text: 'History',
              iconColor: Colors.white,
            ),
            GButton(
              borderRadius: BorderRadius.circular(20),
              padding: const EdgeInsets.all(20),
              iconActiveColor: Colors.white,
              icon: Icons.person_outline_outlined,
              text: 'Profile',
              iconColor: Colors.white,
            ),
          ]),
    );
  }
}
