import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/todos/data/firestore_storage_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';
import 'dart:async';

class FirebaseDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirestoreStorageService _storageService = FirestoreStorageService();

  Future<void> addTodo(WidgetRef ref, File? image) async {
    String? imageUrl;
    if (image != null) {
      imageUrl = await _storageService.uploadImage(image);
      ref.read(createToDoItemControllerProvider.notifier).changeImage(imageUrl);
    }
    TodoModel userInputTodoModel =
        await ref.watch(createToDoItemControllerProvider);
    await _db.collection("Todos").add(userInputTodoModel.toMap());
  }

  Future<List<TodoModel>> loadTodos() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('Todos').get();
    return snapshot.docs
        .map((docSnapshot) => TodoModel.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  /// The function deletes a document with a specific ID from a Firestore collection.
  ///
  /// Args:
  ///   id (String): The id parameter is a string that represents the unique identifier of the document to
  /// be deleted from the Firestore collection.
  Future<void> deleteFromFirestore(String id) async {
    _db.collection('Todos').doc(id).delete();
  }

  Future<void> editTodoInFirestore(
      {String? title, String? description, String? id, String? endDate}) async {
    print("idddddd$id");
    await _db.collection('Todos').doc(id).update(
        {"title": title, "description": description, "endDate": endDate});

    // function to update one property in an item. for now test with isDone
  }

  Future<void> updateItem(
      {required String entryId, required bool entryProperty}) async {
    await _db.collection('Todos').doc(entryId).update({
      'isDone': entryProperty,
    });
  }
}
