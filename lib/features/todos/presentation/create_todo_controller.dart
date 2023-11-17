import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

part 'create_todo_controller.g.dart';

@riverpod
class CreateToDoItemController extends _$CreateToDoItemController {
  TodoModel newTodoModel = TodoModel(
    title: '',
    description: '',
    creationDate: '',
    endDate: '',
    author: '',
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

  void changeCreationDate(String newCreationDate) {
    state.creationDate = newCreationDate;
  }

  void changeEndDate(String newEndDate) {
    state.endDate = newEndDate;
  }

  void changeAuthor(String newAuthor) {
    state.author = newAuthor;
  }
}

final listViewProvider = StateProvider<List<TodoModel>>((ref) => []);
