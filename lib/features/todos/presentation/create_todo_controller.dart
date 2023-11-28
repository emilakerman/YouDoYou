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
    image:
        'https://firebasestorage.googleapis.com/v0/b/youdoyou-aeae2.appspot.com/o/placeholder.png?alt=media&token=9f15b74d-a555-434a-a932-6b7b66548bf7',
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

  void toggleIsDone() async {
    state.isDone = !state.isDone;
  }

  void changeImage(String imageUrl) {
    state.image = imageUrl;
  }
}

// This list contains the uncompleted TODOS.
final listViewProvider = StateProvider<List<TodoModel>>((ref) => []);
// This list contains **completed** TODOS.
final completedListViewProvider = StateProvider<List<TodoModel>>((ref) => []);
// This list contains TODOS shared with the users.
final sharedWithMeListViewProvider = StateProvider<List<TodoModel>>((ref) => []);
