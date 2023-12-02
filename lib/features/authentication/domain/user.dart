import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';

class User {
  String? name;
  String? profilePicture;
  final userId = FirebaseAuthService().getUser() ?? '';

  User({required this.name, required this.profilePicture});

  User setState() {
    getPicture;
    return User(name: name, profilePicture: profilePicture);
  }

  set setName(String name) {
    this.name = name;
  }

  Future<String> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefName = prefs.getString('userName$userId') ?? '';
    setName = prefName;
    return prefName;
  }

  void saveName(String inputName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName$userId', inputName);
    setName = prefs.setString('userName$userId', inputName) as String;
    //print('saveName() as : ${prefs.getString('userName$userId')}');
  }

  //---------PICTURE-----------------------------------------------------------

  set setPicture(String profilePicture) {
    this.profilePicture = profilePicture;
  }

  void getPicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //String imagePath = prefs.getString('imagePath') ?? '';
    String imagePath = prefs.getString('imagePath$userId') ?? '';
    if (kDebugMode) {
      print('is path empty? $imagePath');
    }
    if (imagePath.isNotEmpty) {
      setPicture = imagePath;
    }
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
  UserNotifier() : super(User(name: '', profilePicture: '')) {
    updatefromPref();
  }

  void updatefromPref() {
    state = state.setState();
  }

  void updateName(String newName) {
    state = state.copyWith(name: newName);
  }

  void updateImg(String newImg) {
    state = state.copyWith(profilePicture: newImg);
  }

  void updateAll(String newName, String newImg) {
    state = state.copyWith(name: newName, profilePicture: newImg);
  }
}
