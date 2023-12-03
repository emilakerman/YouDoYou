// This layer is responsible for interacting with the external data source (Firebase).

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_auth.g.dart';

class FirebaseAuthRepository {
  final _auth = FirebaseAuth.instance;

  User? getUser() => _auth.currentUser;
  String? getUserEmail() => _auth.currentUser?.email;

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-notfound') {
      } else if (error.code == 'wrong-password') {}
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}

// Provider that contains the current user UID.
@riverpod
String authState(AuthStateRef ref) {
  return FirebaseAuthRepository().getUser()!.uid.toString();
}

@riverpod
String authEmail(AuthStateRef ref) {
  return FirebaseAuthRepository().getUser()!.email.toString();
}
