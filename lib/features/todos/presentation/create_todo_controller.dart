import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

part 'create_todo_controller.g.dart';

@riverpod
class CreateToDoItemController extends _$CreateToDoItemController {
  
  TodoModel newTodoModel = TodoModel(
    id: DateTime.now().toString(),
    title: '',
    description: '',
    creationDate: DateFormat.yMMMd().format(DateTime.now()).toString(),
    endDate: '',
    author: '',
    isDone: false,
  );
  
  @override
  TodoModel build() {
    return newTodoModel;
  }

  void changeTitle(String newTitle) {
    state.title = newTitle;
  }

  void changeDescription(String newDescription) {
    state.description = newDescription;
  }

  void changeEndDate(String newEndDate) {
    state.endDate = newEndDate;
  }

  void changeAuthor(String newAuthor) {
    state.author = newAuthor;
  }

  void toggleIsDone() {
    state.isDone = !state.isDone;
  }
}

final listViewProvider = StateProvider<List<TodoModel>>((ref) => []);
