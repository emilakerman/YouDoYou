


// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

// class User {
//   String name = '';
//   String? profilePicture;
//   final userId = FirebaseAuthService().getUser() ?? '';
//   // static SharedPreferences preferences = preferences;

//   // static Future init() async => preferences = await SharedPreferences.getInstance();
//   User._privateConstructor();
//   static final User _instance = User._privateConstructor();
//   static User get instance => _instance;
  

//   Future<String> getFromPref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userName = prefs.getString('userName$userId') ?? '';
    
//     if (userName != '') {
//       //var userName = prefs.getString('userName$userId');
//       print('getName(): ${userName}');
//       setName = userName;
//       return userName;
//     } else {
//         print(' 2 getName(): ${name}');
//       return name;
//       setName = 'empty';
//     }
//   }

//   void loadUserName() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     name = prefs.getString('userName$userId') ?? '';
//     print('loading : ${prefs.getString('userName$userId') ?? 'XD'}');
//   }

//   // getTheName() async {
//   //   final String image = '';
//   //   if (name != null) {
//   //     setState(() {
//   //       setName = image;
//   //     });
//   //     SharedPreferences prefs = await SharedPreferences.getInstance();
//   //     prefs.setString('namePath', image);
//   //   }
//   // }

//   Future<String> get getName async {
//     var prefName = await getFromPref();
//     return prefName;
//   }

//   set setName(String name) {
//     this.name = name;
//   }

//   void saveToPref(String inputName) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('userName$userId', inputName);
//     //print('saveName() as : ${prefs.getString('userName$userId')}');
//   }

//   //---------PICTURE-----------------------------------------------------------

//   set setProfilePicture(String profilePicture) {
//     this.profilePicture = profilePicture;
//   }

//   void get getProfilePicture async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     //String imagePath = prefs.getString('imagePath') ?? '';
//     String imagePath = prefs.getString('imagePath$userId') ?? '';
//     if (imagePath.isNotEmpty) {
//       setProfilePicture = imagePath;
//     }
//   }
// }






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

