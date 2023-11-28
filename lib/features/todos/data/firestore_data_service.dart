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
    }

    TodoModel userInputTodoModel = TodoModel(
      id: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.id)),
      title: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.title)),
      description: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.description)),
      creationDate: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.creationDate)),
      endDate: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.endDate)),
      image: imageUrl,
      author: 'Emil',
      isDone: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.isDone)),
    );
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
  }
}
