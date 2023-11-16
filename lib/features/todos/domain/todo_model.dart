import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoModel {
  final String title;
  final String description;
  // Maybe DateTime instaed of string?
  final String creationDate;
  final String endDate;
  // String or "image" data type?
  final String? image;
  // This is the user, so maybe not a string but some ID?
  final String author;

  TodoModel({
    required this.title,
    required this.description,
    required this.creationDate,
    required this.endDate,
    this.image,
    required this.author,
  });
}
// Keep commented save for later.
// final toDoProvider = StateProvider<TodoModel>(
//   (ref) {
//     return TodoModel(
//       title: "TITEL",
//       description: "DESCRIPTION",
//       creationDate: "2023-11-16",
//       endDate: "2023-11-31",
//     );
//   },
// );