// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

class User {
  String? name;
  String? profilePicture;
  final userId = FirebaseAuthService().getUser() ?? '';
  final useremail = FirebaseAuthService().getUser()?.email ?? '';

  User({this.name, this.profilePicture});

  User setInitState() {
    print('set Init being called ${name} ');
    getName();
    getPicture();
    return User(name: name, profilePicture: profilePicture);
  }

  getPicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('imagePath$userId') ?? '';

    if (imagePath.isNotEmpty) {
      setPicture = imagePath;
    } else {
      return;
    }
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefName = prefs.getString('userName$userId') ?? '';

    if (prefName.isNotEmpty) {
      print('checking prefName${prefName}');
      setName = prefName;
    } else {
      return;
    }
  }

  //---------SETTERS/DATACLASS-----------------------------------------------------------

  set setPicture(String newPicture) {
    profilePicture = newPicture;
  }

  set setName(String newName) {
    profilePicture = newName;
  }

  User copyWith({
    String? name,
    String? profilePicture,
  }) {
    return User(
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User()) {
    print('${state.name} ${state.profilePicture}');
    state = state.setInitState();
        print('${state.name} ${state.profilePicture}');
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updateImg(String newImg) {
    state = state.copyWith(profilePicture: newImg);
  }

  void updateAll({required String newName, required String newImg}) {
    state = state.copyWith(name: newName, profilePicture: newImg);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);
