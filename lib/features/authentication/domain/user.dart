import 'package:shared_preferences/shared_preferences.dart';

class User {
  String? name;
  String? profilePicture;

  User();

  String? get getName {
    if (name == null) {
      return '';
    } else {
      return name;
    }
  }

  set setName(String name) {
    this.name = name;
  }

  void get getProfilePicture async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('imagePath') ?? '';
    if (imagePath.isNotEmpty) {
      profilePicture = imagePath;
    }
  }

  set setProfilePicture(String profilePicture) {
    this.profilePicture = profilePicture;
  }
}
