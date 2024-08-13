import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:translator_app/views/profile/about.dart';
import 'package:translator_app/views/profile/cardtile.dart';
import 'package:translator_app/views/profile/editprofile.dart';
import 'package:translator_app/views/profile/viewprofile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? _user = FirebaseAuth.instance.currentUser;
  Future<void> launchEmail() async {
    // ios specification
    final String subject = "Subject:";
    final String stringText = "Some Message:";
    String uri =
        'mailto:hubstech0@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      print("No email client found");
    }
  }

  @override
  Widget build(BuildContext context) {
    final String _uid = _user!.uid;
    return Scaffold(
      backgroundColor: const Color(0xff151716),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> userData =
                  snapshot.data!.data() as Map<String, dynamic>;
              String firstName = userData['firstName'] ?? 'User';
              String lastName = userData['lastName'] ?? '';
              String email = userData['email'] ?? 'No email';
              String? profile = userData['url'] as String?;
              // String firstName = snapshot.data?.get('firstName') ?? 'User';
              // String lastName = snapshot.data?.get('lastName') ?? 'User';
              // String email = snapshot.data?.get('email') ?? 'User';
              // String? profile = snapshot.data?.get('url') as String?;

              return Center(
                child: ListView(
                  shrinkWrap: true,
                  //  padding: const EdgeInsets.symmetric(vertical: 60),
                  children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                        image: profile != null
                            ? DecorationImage(
                                image: NetworkImage(profile), fit: BoxFit.cover)
                            : null,
                      ),
                      child: profile == null
                          ? Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.grey[300],
                            )
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        '$firstName ' '$lastName',
                        style: GoogleFonts.poppins(
                            fontSize: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    Center(
                      child: Text(
                        email,
                        style: GoogleFonts.poppins(
                            fontSize: 17, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //  Text('General'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Divider(
                        color: Colors.grey[800],
                      ),
                    ),
                    CustomTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.grey[200],
                      ),
                      text: 'Profile',
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewProfile()));
                      },
                    ),
                    CustomTile(
                      leading: Icon(
                        Icons.edit_note,
                        color: Colors.grey[200],
                      ),
                      text: 'Edit profile',
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()));
                      },
                    ),
                    CustomTile(
                      leading: Icon(
                        Icons.support,
                        color: Colors.grey[200],
                      ),
                      text: 'About project',
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutPage()));
                      },
                    ),
                    CustomTile(
                      leading: Icon(
                        Icons.feedback,
                        color: Colors.grey[200],
                      ),
                      text: 'Feedback',
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        launchEmail();
                      },
                    ),
                    CustomTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: Colors.grey[200],
                      ),
                      text: 'Logout',
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),

                    CustomTile(
                      text: 'Delete account',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete your Account?'),
                              content: const Text(
                                  '''If you select Delete we will delete your account on our server.

                                  Your app data will also be deleted and you won't be able to retrieve it.

                                  Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    deleteUserAccount();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      trailing: Icon(
                        size: 20,
                        Icons.arrow_forward_ios,
                        color: Colors.grey[200],
                      ),
                      leading: Icon(
                        Icons.delete_forever,
                        color: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: const Text('Error report about this'));
            }
          }),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData =
          FirebaseAuth.instance.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}
