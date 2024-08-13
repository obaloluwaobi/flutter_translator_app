import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';
import 'package:translator_app/views/history/historytile.dart';
import 'package:translator_app/views/history/nohistory.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String _uid = _user!.uid;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff151716),
        title: Text(
          'History',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xff151716),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(_uid)
            .collection("history")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const NoHistory();
          }
          if (snapshot.hasError) {
            return const Center(child: Text('error'));
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, int index) {
                var getData = snapshot.data?.docs[index];
                String docID = getData!.id;

                return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      color: const Color.fromARGB(255, 238, 140, 173),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete_forever_outlined,
                          color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        var delete = FirebaseFirestore.instance
                            .collection("users")
                            .doc(_uid)
                            .collection('history')
                            .doc(docID);
                        delete.delete();
                        toastification.show(
                            alignment: Alignment.topCenter,
                            style: ToastificationStyle.fillColored,
                            type: ToastificationType.success,
                            context: context,
                            title: const Text('deleted'),
                            description: const Text('You swiped to delete'),
                            autoCloseDuration: const Duration(seconds: 2));

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text("deleted  successfully")));
                      });
                    },
                    child: HistoryTile(getData: getData));
              });
        },
      ),
    );
  }
}
