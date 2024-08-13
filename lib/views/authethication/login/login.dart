import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:translator_app/views/authethication/resetpassword/forgetpassword.dart';
import 'package:translator_app/views/authethication/register/create_acct.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegister;
  const LoginPage({super.key, required this.showRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visible = false;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future signin() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return LoadingAnimationWidget.hexagonDots(
              size: 50,
              color: Colors.white,
            );
          });
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('invalid-email',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-disabled") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-disabled',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-not-found") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-not-found',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-credential") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('wrong-password',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff151716),
      body: Form(
          key: _key,
          child: FadeInUp(
            child: Center(
              child: ListView(shrinkWrap: true, children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30.0, right: 30, bottom: 40),
                  child: Text(
                    'Login',
                    style:
                        GoogleFonts.poppins(fontSize: 40, color: Colors.white),
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
                    validator: (email) {
                      if (email == null || email.isEmpty) {
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
                  height: 30,
                ),
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
                    controller: _passwordController,
                    validator: (password) {
                      if (password == null || password.isEmpty) {
                        return 'Please enter your password';
                      } else {
                        return null;
                      }
                    },
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Enter your password',
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
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordPage()));
                          },
                          child: Text(
                            'Forget Password?',
                            style:
                                GoogleFonts.poppins(color: Colors.green[400]),
                          ))
                    ],
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
                            signin();
                          }
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                              fontSize: 25, color: Colors.black),
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.grey[300]),
                    ),
                    GestureDetector(
                        onTap: () {
                          widget.showRegister();
                        },
                        child: Text(
                          'Sign up',
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[200]),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          )),
    );
  }
}
