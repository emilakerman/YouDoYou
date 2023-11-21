import 'package:intl/intl.dart';

class ToDoItem {
  String id = DateTime.now().toString();
  String title;
  String description;
  DateTime? creationDate = DateTime.now();
  DateTime? endDate;
  bool isDone;
  String? image;
  String author;

  ToDoItem({
    required this.title,
    required this.description,
    this.creationDate,
    this.endDate,
    this.isDone = false,
    this.image,
    required this.author,
  });
}
