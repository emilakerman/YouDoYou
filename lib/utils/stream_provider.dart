import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

final streamProviderExampleProvider = ChangeNotifierProvider<StreamProviderExample>((ref) {
  return StreamProviderExample();
});

class StreamProviderExample extends ChangeNotifier {
  int previousCollectionSize = 0;
  bool widgetBuilt = false;

  StreamProviderExample() {
    FirebaseAuthService firebaseAuthService = FirebaseAuthService();

    FirebaseFirestore.instance
        .collection('Shared')
        .where('email', isEqualTo: firebaseAuthService.getUserEmail())
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
