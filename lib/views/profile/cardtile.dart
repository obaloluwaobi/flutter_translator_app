import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTile extends StatelessWidget {
  final Icon trailing;
  final Icon leading;
  final String text;
  final VoidCallback onPressed;

  const CustomTile(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.trailing,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        child: ListTile(
          leading: leading,
          trailing: trailing,
          title: Text(
            text,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
