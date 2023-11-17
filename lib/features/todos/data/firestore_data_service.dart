import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class FirebaseDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodo(WidgetRef ref) async {
    TodoModel userInputTodoModel = TodoModel(
      title: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.title)),
      description: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.description)),
      creationDate: await ref.watch(createToDoItemControllerProvider.notifier
          .select((value) => value.newTodoModel.creationDate)),
      endDate: await ref.watch(
          createToDoItemControllerProvider.notifier.select((value) => value.newTodoModel.endDate)),
      author: 'Emil',
    );
    await _db.collection("Todos").add(userInputTodoModel.toMap());
  }
}
