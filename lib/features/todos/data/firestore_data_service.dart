import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

class FirebaseDataService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTodo() async {
    TodoModel mockModel = TodoModel(
      title: 'Köpa morot',
      description: 'Jättesnabbt',
      creationDate: '2023-11-17',
      endDate: '2023-12-12',
      author: 'Emil',
    );
    await _db.collection("Todos").add(mockModel.toMap());
  }
}
