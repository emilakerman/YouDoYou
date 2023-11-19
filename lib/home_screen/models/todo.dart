class ToDoType{
  String title;
  String description;
  DateTime creationDate;
  DateTime? endDate;
  bool? isDone;
  String? image;
  String author;

    ToDoType({
    required this.title,
    this.description = '',
    required this.creationDate,
    this.endDate,
    this.isDone = false,
    this.image,
    required this.author,
  });

}