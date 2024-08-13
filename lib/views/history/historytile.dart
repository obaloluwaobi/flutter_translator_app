import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryTile extends StatelessWidget {
  HistoryTile({
    super.key,
    required this.getData,
  });

  final QueryDocumentSnapshot<Object?>? getData;

  final style = GoogleFonts.poppins(fontSize: 20, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    // final time = getData?['time'];
    // final formattedTime = DateTime.parse(time.toDate().toString()).toString();

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: ListTile(
        title: Text(
          getData?['from'],
          style: style,
        ),
        subtitle: Text(
          getData?['to'],
          style: style,
        ),
      ),
    );
  }
}
