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

  Future<void> loadSingleTodo(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('Todos')
              .doc("2023-11-22 14:10:56.897199")
              .get();

      if (documentSnapshot.exists) {
        // Document exists, you can access the data using documentSnapshot.data()
        Map<String, dynamic> data = documentSnapshot.data()!;
        print('Todo Data: $data');
      } else {
        print('Todo with ID  does not exist.');
      }
    } catch (e) {
      print('Error retrieving todo: $e');
    }
  }
}
