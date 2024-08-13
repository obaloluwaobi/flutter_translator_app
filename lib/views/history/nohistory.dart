import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151716),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete_outline_sharp,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'No History',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 30),
                ),
              ],
            ),
            Center(
              child: Text(
                'You do not have any records',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
