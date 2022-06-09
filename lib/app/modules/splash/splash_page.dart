import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';

class SplashPage extends StatefulWidget {
  // Constructor
  const SplashPage({super.key});

  // Attribute
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Methods
  @override
  void initState() {
    super.initState();
    // Sign out user
    Modular.get<AuthService>().signOut();
    // Firebase listener
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is not logged
        Modular.to.navigate('/login');
      } else {
        Modular.to.navigate('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF0092B9),
              Color(0XFF0167B2),
            ],
          ),
        ),
        child: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
