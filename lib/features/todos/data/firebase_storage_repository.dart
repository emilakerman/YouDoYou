import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_storage_repository.g.dart';

class FirebaseStorageRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<String> uploadImage(File image) async {
    String imageName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    Reference ref = _storage.ref().child("images/").child(imageName);
    UploadTask uploadTask = ref.putFile(image);
    await uploadTask.whenComplete(() {});
    return uploadTask.snapshot.ref.getDownloadURL();
  }
}

// Provider that contains an instance of Firebase Storage.
@riverpod
FirebaseStorageRepository firebaseStorageRepository(FirebaseStorageRepositoryRef ref) {
  return FirebaseStorageRepository();
}
