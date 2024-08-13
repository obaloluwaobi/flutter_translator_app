// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  Future reset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder: (_) {
            return const AlertDialog(
              content: Text('reset password link has been sent to your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Wrong email address!'),
              content: Text('this email does not exist!'),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151716),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        ),
        centerTitle: true,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff151716),
      ),
      body: Form(
        key: _key,
        child: Center(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Enter the email address associated with your account and we\'ll send the you link to reset your password',
                  style: TextStyle(
                      color: Colors.grey[200],
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  validator: (password) {
                    if (password == null || password.isEmpty) {
                      return 'Please enter your email address';
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
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon:
                          Icon(Icons.email_outlined, color: Colors.grey[400])),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          reset();
                        }
                      },
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 25, color: Colors.black),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
