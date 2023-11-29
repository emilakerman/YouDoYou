import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/todos/data/firestore_storage_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';
import 'dart:async';

class FirestoreDataRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodo(
    WidgetRef ref,
    File? image,
    String uid,
  ) async {
    String? imageUrl;

    if (image != null) {
      imageUrl = await ref.read(firebaseStorageRepositoryProvider).uploadImage(image);
      ref.read(createToDoItemControllerProvider.notifier).changeImage(imageUrl);
    }

    TodoModel userInputTodoModel = await ref.watch(createToDoItemControllerProvider);

    DocumentReference userDocumentRef = _db.collection("Users").doc(uid);
    CollectionReference todosCollectionRef = userDocumentRef.collection("Todos");
    await todosCollectionRef.add(userInputTodoModel.toMap());
  }

  /// The function deletes a document with a specific ID from a Firestore collection.
  Future<void> deleteFromFirestore({
    required String id,
    required String uid,
  }) async {
    await _db.collection('Users').doc(uid).collection('Todos').doc(id).delete();
  }

  Future<void> editTodoInFirestore({
    String? title,
    String? description,
    String? id,
    String? endDate,
    String? uid,
  }) async {
    await _db
        .collection('Users')
        .doc(uid)
        .collection('Todos')
        .doc(id)
        .update({"title": title, "description": description, "endDate": endDate});
  }

  // Update isDone value on firestore.
  Future<void> updateItem({
    required String entryId,
    required bool entryProperty,
    required String uid,
  }) async {
    await _db.collection('Users').doc(uid).collection('Todos').doc(entryId).update({
      'isDone': entryProperty,
    });
  }
}

// Provider that contains an instance of Firestore.
final firestoreRepositoryProvider = Provider<FirestoreDataRepository>((ref) {
  return FirestoreDataRepository();
});