import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';
import 'dart:async';

class FirebaseDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodo(WidgetRef ref) async {
    TodoModel userInputTodoModel = TodoModel(
      id: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.id)),
      title: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.title)),
      description: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.description)),
      creationDate: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.creationDate)),
      endDate: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.endDate)),
      author: 'Emil',
      isDone: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.isDone)),
    );
    await _db.collection("todos").add(userInputTodoModel.toMap());
  }

  Future<List<TodoModel>> loadTodos() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('todos').get();
    return snapshot.docs.map((docSnapshot) => TodoModel.fromDocumentSnapshot(docSnapshot)).toList();
  }

  // function to update one property in an item. for now test with isDone
  Future<void> updateItem({required String entryId, required bool entryProperty}) async {
          await _db.collection('todos').doc(entryId).update({
        'isDone': entryProperty,
      });
  }
}
