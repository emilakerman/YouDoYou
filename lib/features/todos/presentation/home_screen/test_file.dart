//notifyListeners() in update functions

  // void testAddItem() {
  //   FirebaseFirestore.instance.collection('user_todos').add(
  //     {
  //       'id': DateTime.now().toString(),
  //       'title': 'whatever3',
  //       'description': 'do this and that and more of that',
  //       'creationDate': DateTime.now().toString(),
  //       'endDate': DateTime.now().toString(),
  //       'isDone': false,
  //       'image': null,
  //       'author': 'joel',
  //     },
  //   );
  // }



// return ListView.builder(
//           itemCount: documents.length,
//           itemBuilder: (context, index) {
//             var item = ToDoItem(
//               title: documents[index]['title'],
//             description: documents[index]['description'],
//             creationDate: documents[index]['creationDate'],
//             endDate: documents[index]['endDate'],
//             isDone: documents[index]['isDone'],
//             image: documents[index]['image'],
//             author: documents[index]['author']
//             );

//             return ToDoEntry(entry: item);
//           },
//         );


// void updateTodo(String id, TodoModel updatedTodo){
//   final entryIndex = listViewProvider.indexWhere((todo)=> todo.id == id);
//   //.removeWhere(id==id)
//   if(entryIndex >= 0){
//     listViewProvider[entryIndex] = updatedTodo;
//   }else{
//     print(...);
//   }

// }

// void update(TodoModel updatedPerson){
//   final index = people.indexOf(updatedPerson);
//   TodoModel oldPerson = people[index];
//   if(oldPerson.id == updatedPerson.id){
//     people[index] = updatedPerson;
//   }
//   notifyListeners();
// }

