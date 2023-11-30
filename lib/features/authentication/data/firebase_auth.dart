// This layer is responsible for interacting with the external data source (Firebase).

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService {
  final _auth = FirebaseAuth.instance;

  User? getUser() => _auth.currentUser;

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-notfound') {

      } else if (error.code == 'wrong-password') {
        
      }
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}

// Provider that contains the current user UID.
final authStateProvider = Provider<String>((ref) {
  return FirebaseAuthService().getUser()!.uid.toString();
});
