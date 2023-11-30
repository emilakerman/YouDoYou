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
    image: 'https://i.imgur.com/DHLl4HG.jpeg',
    isDone: false,
    email: '',
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
    // state.image = imageUrl;
    state.image = 'https://i.imgur.com/DHLl4HG.jpeg';
  }

  void changeEmail(String email) {
    state.email = email;
  }
}

// Toggle isShared provider.
final toggleSharedProvider = StateProvider<bool>((ref) => false);
