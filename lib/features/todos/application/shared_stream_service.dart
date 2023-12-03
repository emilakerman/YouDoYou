import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

class SharedStreamService extends ChangeNotifier {
  int previousCollectionSize = 0;
  bool widgetBuilt = false;

  SharedStreamService() {
    FirebaseAuthRepository firebaseAuthRepository = FirebaseAuthRepository();

    FirebaseFirestore.instance
        .collection('Shared')
        .where('email', isEqualTo: firebaseAuthRepository.getUserEmail())
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      final currentCollectionSize = snapshot.size;

      if (widgetBuilt && currentCollectionSize > previousCollectionSize) {
        notifyListeners();
      }

      previousCollectionSize = currentCollectionSize;
    });
  }
}

final sharedStreamServiceProvider = ChangeNotifierProvider<SharedStreamService>((ref) {
  return SharedStreamService();
});
