import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  // String? avatarUrl;
  final TextStyle inputStyle =
      GoogleFonts.poppins(color: Colors.white, fontSize: 18);
  final labelstyle = GoogleFonts.poppins(fontSize: 20, color: Colors.white);
  final storage = FirebaseStorage.instance;

  final _fnameController = TextEditingController();

  final _lnameController = TextEditingController();

  final _departmentController = TextEditingController();

  final _phoneController = TextEditingController();

  final _matricController = TextEditingController();
  File? photo;

  final ImagePicker picker = ImagePicker();
  Future imgPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        //   avatarUrl = null;
      } else {
        print('No image selected');
      }
    });
  }

  // final List<String> avatarUrls = [
  //   'assets/profile/1.jpg',
  //   'assets/profile/2.jpg',
  //   'assets/profile/3.jpg'
  // ];
  bool isLoading = false;
  Future _createProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (_fnameController.text.isNotEmpty &&
          _lnameController.text.isNotEmpty &&
          _departmentController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _matricController.text.isNotEmpty) {
        final User? _user = FirebaseAuth.instance.currentUser;

        final String _uid = _user!.uid;
        String? downloadURL;
        if (photo != null) {
          final fileName = basename(photo!.path);
          final destination = 'files/$fileName';

          UploadTask uploadTask = FirebaseStorage.instance
              .ref(destination)
              .child('profile$_uid/')
              .putFile(photo!);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          downloadURL = await taskSnapshot.ref.getDownloadURL();

          print(downloadURL);
        }

        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          // 'url': imageUrl,
          'email': _user.email,
          'firstName': _fnameController.text.trim(),
          'lastName': _lnameController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'matricNum': _matricController.text.trim(),
          'department': _departmentController.text.trim(),
          if (downloadURL != null) 'url': downloadURL.toString(),
        });
      }
    } on FirebaseException catch (e) {
      print('empty field');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          'Create profile',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: const Color(0xff151716),
      ),
      backgroundColor: const Color(0xff151716),
      body: Center(
        child: ListView(
          //padding: const EdgeInsets.symmetric(horizontal: 39),
          shrinkWrap: true,
          children: [
            GestureDetector(
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (contsxt) {
                //       return AlertDialog(
                //         title: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Text('Choose Image',
                //                 style: GoogleFonts.poppins(fontSize: 16)),
                //             IconButton(
                //                 onPressed: () {}, icon: Icon(Icons.cancel))
                //           ],
                //         ),
                //         content: Container(
                //           height: 100,
                //           child: Row(
                //             //crossAxisAlignment: ,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   IconButton(
                //                       onPressed: () {},
                //                       icon: Icon(Icons.image)),
                //                   Text('Gallery',
                //                       style: GoogleFonts.poppins(fontSize: 16)),
                //                 ],
                //               ),
                //               SizedBox(
                //                 width: 4,
                //               ),
                //               SizedBox(
                //                 width: 200,
                //                 child: ListView.builder(
                //                     padding:
                //                         EdgeInsets.symmetric(horizontal: 5),
                //                     scrollDirection: Axis.horizontal,
                //                     itemCount: avatarUrls.length,
                //                     itemBuilder: (context, index) {
                //                       return GestureDetector(
                //                         onTap: () {
                //                           setState(() {
                //                             avatarUrl = avatarUrls[index];
                //                             photo = null;
                //                           });
                //                           Navigator.of(context).pop();
                //                         },
                //                         child: CircleAvatar(
                //                           radius: 25,
                //                           backgroundImage:
                //                               AssetImage(avatarUrls[index]),
                //                         ),
                //                       );
                //                     }),
                //               ),
                //             ],
                //           ),
                //         ),
                //       );
                //     });
                imgPick();
              },
              child: photo != null //|| avatarUrl != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: Colors.black,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: FileImage(photo!),
                              // photo != null
                              //     ? FileImage(photo!) as ImageProvider
                              //     : AssetImage(avatarUrl!),
                              fit: BoxFit.fitWidth)),
                      // child: Image.file(
                      //   photo!,
                      //   fit: BoxFit.cover,
                      // )
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.person,
                            size: 130,
                          ),
                        ),
                        const Positioned(
                          top: 90,
                          left: 130,
                          right: 0,
                          bottom: 10,
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _fnameController,
                style: inputStyle,
                decoration: InputDecoration(
                    labelText: 'First name',
                    labelStyle: labelstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'enter your first name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.email_outlined)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _lnameController,
                style: inputStyle,
                decoration: InputDecoration(
                    labelText: 'Last name',
                    labelStyle: labelstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'enter your last name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.email_outlined)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  style: inputStyle,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    labelStyle: labelstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: '',
                    prefixIcon: const Icon(Icons.call),
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _matricController,
                style: inputStyle,
                decoration: InputDecoration(
                    labelText: 'Matric no.',
                    labelStyle: labelstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'matriculation number',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.email_outlined)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _departmentController,
                style: inputStyle,
                decoration: InputDecoration(
                    labelText: 'Department',
                    labelStyle: labelstyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: 'enter your department',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.email_outlined)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: isLoading
                      ? null
                      : () {
                          _createProfile();
                        },
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Create profile',
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.black),
                        )),
            )
          ],
        ),
      ),
    );
  }
}
