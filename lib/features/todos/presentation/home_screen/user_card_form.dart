import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';

class UserCardForm extends StatefulWidget {
  const UserCardForm({super.key});

  @override
  State<UserCardForm> createState() => _UserCardFormState();
}

class _UserCardFormState extends State<UserCardForm> {
  var userId = FirebaseAuthService().getUser() ?? '';
  User user = User.instance;
  final ImagePicker _imagePicker = ImagePicker();
  final _titleController = TextEditingController();

  String? _selectedPicture;

  _startImagePicker() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // setState(() {
      //   user.setProfilePicture = image.path;
      // });
      _selectedPicture = image.path;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath$userId', image.path);
    }
  }

  void _submitData() {
    setState(() {
      user.setName = _titleController.text;
      user.setProfilePicture = _selectedPicture!;
    });

//image too
    if (user.name == null) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'User Name'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  // 5) if theres a date show something else. before this step it was just Text(No date chosen)
                  //it is needed to use ! because it is an optional variable
                  //wrap the Text in a Expanded to create space between Text and Button
                  Expanded(
                    child: Text(
                      _selectedPicture == null ? 'No picture selected' : 'Selected Picture',
                    ),
                  ),
                  //Text('No Date Chosen'),
                  TextButton(
                    style: const ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(AppColors.blue),
                    ),
                    onPressed: _startImagePicker,
                    child: const Text(
                      'Choose Picture',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            // 2) add a button that opens up a datepicker
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: const ButtonStyle(),
                onPressed: _submitData,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
