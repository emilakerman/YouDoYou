import 'package:shared_preferences/shared_preferences.dart';

class LocallyStoredData {
  final String key = 'name';
  final String key2 = 'image';

  void saveName({required String name}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, name);
  }

  Future<String> readName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedName = prefs.getString(key) ?? "";
    return savedName;
  }

  void saveImage({required String image}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key2, image);
  }

  Future<String> readImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedImage = prefs.getString(key2) ?? "";
    return savedImage;
  }
}
