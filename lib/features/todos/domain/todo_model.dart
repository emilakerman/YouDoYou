class TodoModel {
  String title;
  String description;
  // Maybe DateTime instead of string?
  String creationDate;
  String endDate;
  // String or "image" data type?
  String? image;
  // This is the user, so maybe not a string but some ID?
  String author;

  TodoModel({
    required this.title,
    required this.description,
    required this.creationDate,
    required this.endDate,
    this.image,
    required this.author,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'creationDate': creationDate,
      'endDate': endDate,
      'image': image,
      'author': author
    };
  }
}
