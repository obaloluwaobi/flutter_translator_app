import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateAcctPage extends StatefulWidget {
  final VoidCallback showLogin;
  const CreateAcctPage({super.key, required this.showLogin});

  @override
  State<CreateAcctPage> createState() => _CreateAcctPageState();
}

class _CreateAcctPageState extends State<CreateAcctPage> {
  bool visible = false;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future createAccount() async {
    showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return LoadingAnimationWidget.hexagonDots(
            size: 50,
            color: Colors.white,
          );
        });
    try {
      if (confirmPassword()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == "email-already-in-use") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'The email address is already in use by another account.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('This email address does not exist.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "operation-not-allowed") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('this operation is not allowed',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "weak-password") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Weak Password!',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
    }
  }

  bool confirmPassword() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    //_fnameController.dispose();
    _confirmPasswordController.dispose();
    // _lnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151716),
      body: Form(
          key: _key,
          child: FadeInUp(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 40),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            widget.showLogin();
                          },
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.white)),
                      Text(
                        'Create an account',
                        style: GoogleFonts.poppins(
                            fontSize: 30, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Email',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else {
                        return null;
                      }
                    },
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Enter your email address',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Colors.grey[400])),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), //user enter there password here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Password',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    obscureText: !visible,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be longer than 6 character';
                      }
                    },
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Create your password',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: visible
                                ? Icon(Icons.visibility_outlined,
                                    color: Colors.grey[400])
                                : Icon(Icons.visibility_off_outlined,
                                    color: Colors.grey[400]))),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), //user enter there confirm password here
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Confirm password',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextFormField(
                    obscureText: !visible,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be longer than 6 character';
                      }
                    },
                    controller: _confirmPasswordController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Confirm password',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                        prefixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: visible
                                ? Icon(Icons.visibility_outlined,
                                    color: Colors.grey[400])
                                : Icon(Icons.visibility_off_outlined,
                                    color: Colors.grey[400]))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            createAccount();
                          }
                        },
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                              fontSize: 25, color: Colors.black),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.grey[300]),
                    ),
                    GestureDetector(
                        onTap: () {
                          widget.showLogin();
                        },
                        child: Text(
                          'Sign in',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200]),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )),
    );
  }
}
