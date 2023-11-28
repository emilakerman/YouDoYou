import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

class User {
  String? name;
  String? profilePicture;
  final userId = FirebaseAuthService().getUser() ?? '';

  User._privateConstructor();
  static final User _instance = User._privateConstructor();
  static User get instance => _instance;

  String get getName {
    if (name == null) {
      return '';
    } else {
      return name!;
    }
  }

  // getTheName() async {
  //   final String image = '';
  //   if (name != null) {
  //     setState(() {
  //       setName = image;
  //     });
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('namePath', image);
  //   }
  // }

  set setName(String name) {
    this.name = name;
  }

  set setProfilePicture(String profilePicture) {
    this.profilePicture = profilePicture;
  }

  void get getProfilePicture async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String imagePath = prefs.getString('imagePath') ?? '';
    String imagePath = prefs.getString('imagePath$userId') ?? '';
    if (imagePath.isNotEmpty) {
      setProfilePicture = imagePath;
    }
  }
}
