import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/authentication/presentation/auth_screen.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuthService().authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // USER LOGGED IN
            return Home();
          } else {
            // USER NOT LOGGED IN
            return AuthScreen();
          }
        },
      ),
    );
  }
}
