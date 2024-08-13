import 'package:flutter/material.dart';
import 'package:translator_app/views/authethication/login/login.dart';
import 'package:translator_app/views/bottomnavbar.dart';
import 'package:translator_app/views/authethication/register/create_acct.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;
  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(showRegister: toggleView);
    } else {
      return CreateAcctPage(showLogin: toggleView);
    }
  }
}
