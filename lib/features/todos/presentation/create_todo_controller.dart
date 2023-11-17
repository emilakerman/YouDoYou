import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

part 'create_todo_controller.g.dart';

@riverpod
class CreateToDoItemController extends _$CreateToDoItemController {
  TodoModel newModel = TodoModel(
    title: '',
    description: '',
    creationDate: '',
    endDate: '',
    author: '',
  );

  @override
  TodoModel build() => newModel;

  void changeTitle(String newTitle) {
    // state.title = newTitle;
  }
}
