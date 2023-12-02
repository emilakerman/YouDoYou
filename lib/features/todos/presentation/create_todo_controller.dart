import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo/create_to_do_item.dart';

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

  void changeState(String newData, Enum field) {
    switch (field) {
      case Fields.title:
        state.title = newData;
      case Fields.description:
        state.description = newData;
      case Fields.endDate:
        state.endDate = newData;
      case Fields.author:
        state.author = newData;
      case Fields.image:
        state.image = newData;
      case Fields.email:
        state.email = newData;
    }
  }

  void changeImage(String imageUrl) {
    state.image = imageUrl;
  }

  void toggleIsDone() async {
    state.isDone = !state.isDone;
  }
}

// Toggle isShared provider.
final toggleSharedProvider = StateProvider<bool>((ref) => false);
