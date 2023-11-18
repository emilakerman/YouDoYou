class User {
  String? name;
  String? profilePicture;

  User({this.name, this.profilePicture});

  String? getName() {
    if (name == null) {
      return '';
    } else {
      return name;
    }
  }

  void setname(String name) {
    this.name = name;
  }

  String? getProfilePicture() {
    return profilePicture;
  }

  void setProfilePicture(String profilePicture) {
    this.profilePicture = profilePicture;
  }
}
