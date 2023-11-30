import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home_header.dart';

class UserCardForm extends ConsumerStatefulWidget {
  const UserCardForm({super.key});

  @override
  ConsumerState<UserCardForm> createState() => _UserCardFormState();
}

class _UserCardFormState extends ConsumerState<UserCardForm> {
  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider.notifier);
    var userId = FirebaseAuthService().getUser() ?? '';
    final ImagePicker _imagePicker = ImagePicker();
    final nameController = TextEditingController();
    String? _selectedPicture;

  _startImagePicker() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedPicture = image.path;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath$userId', image.path);
    }

    void _submitData() {
      if (nameController.text.isNotEmpty && _selectedPicture != null) {
        user.updateAll(nameController.text, _selectedPicture!);
      } else if (_selectedPicture == null) {
        user.updateName(nameController.text);
      } else if (nameController.text.isEmpty) {
        user.updateImg(_selectedPicture!);
      }
      Navigator.of(context).pop();
    }

    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'User Name'),
              controller: nameController,
              onSubmitted: (_) => _submitData,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedPicture == null ? 'No picture selected' : 'Selected Picture',
                    ),
                  ),
                  _selectedPicture == null
                      ? SizedBox(
                          width: 10,
                        )
                      : Icon(
                          AppIcons.addPhoto,
                        ),
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