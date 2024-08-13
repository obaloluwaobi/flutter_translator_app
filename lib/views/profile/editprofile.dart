import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _key = GlobalKey<FormState>();
  File? photo;
  final ImagePicker picker = ImagePicker();
  Future imgPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  final storage = FirebaseStorage.instance;
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _phoneController = TextEditingController();
  final _matricController = TextEditingController();
  Future _updateProfile() async {
    try {
      if (_fnameController.text.isNotEmpty &&
          _lnameController.text.isNotEmpty &&
          _departmentController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _matricController.text.isNotEmpty) {
        final User? _user = FirebaseAuth.instance.currentUser;
        final String _uid = _user!.uid;
        if (photo == null) return;
        final fileName = basename(photo!.path);
        final destination = 'files/$fileName';

        UploadTask uploadTask = FirebaseStorage.instance
            .ref(destination)
            .child('profile$_uid/')
            .putFile(photo!);

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String downloadURL = await taskSnapshot.ref.getDownloadURL();

        print(downloadURL);

        await FirebaseFirestore.instance.collection('users').doc(_uid).update({
          'firstName': _fnameController.text.trim(),
          'lastName': _lnameController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'matricNum': _matricController.text.trim(),
          'department': _departmentController.text.trim(),
          'url': downloadURL.toString()
        });
      }
    } on FirebaseException catch (e) {
      print('empty field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        title: const Text(
          'Edit profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff151716),
      ),
      backgroundColor: const Color(0xff151716),
      body: Form(
        key: _key,
        child: Center(
          child: ListView(
            //padding: const EdgeInsets.symmetric(horizontal: 39),
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  imgPick();
                },
                child: photo != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          photo!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
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
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      labelText: 'First name',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Edit your first name',
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
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      labelText: 'Last name',
                      labelStyle: TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Edit your last name',
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
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: '',
                      prefix: const Text('+234 '),
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
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      labelText: 'Matric no.',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Edit your matriculation number',
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
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                      labelText: 'Department',
                      labelStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Edit your department',
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
                    onPressed: () {
                      _updateProfile();
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
