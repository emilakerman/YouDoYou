import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String title;
  String description;
  String? creationDate;
  String endDate;
  // String or "image" data type?
  String? image;
  String author;
  bool isDone;
  String? email;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.creationDate,
    required this.endDate,
    this.image,
    required this.author,
    required this.isDone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'creationDate': creationDate,
      'endDate': endDate,
      'image': image,
      'author': author,
      'isDone': isDone,
      'email': email,
    };
  }

  TodoModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.data()!['id'],
        title = doc.data()!['title'],
        description = doc.data()!['description'],
        creationDate = doc.data()!['creationDate'],
        endDate = doc.data()!['endDate'],
        image = doc.data()!['image'],
        author = doc.data()!['author'],
        isDone = doc.data()!['isDone'],
        email = doc.data()!['email'];
}
