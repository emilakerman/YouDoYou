import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home_header.dart';
import 'package:youdoyou/utils/locally_stored_data.dart';

class UserCardForm extends ConsumerStatefulWidget {
  const UserCardForm({super.key});

  @override
  ConsumerState<UserCardForm> createState() => _UserCardFormState();
}

class _UserCardFormState extends ConsumerState<UserCardForm> {
  final ImagePicker imagePicker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  String? selectedPicture;

  void startImagePicker() async {
    final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedPicture = image.path;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath${FirebaseAuthService().getUser()}', image.path);
    }
  }

  void submitData() {
    LocallyStoredData localStorage = LocallyStoredData();
    localStorage.saveName(name: nameController.text);
    localStorage.saveImage(image: selectedPicture!);

    // var user = ref.watch(userProvider.notifier);

    // if (nameController.text.isNotEmpty && selectedPicture != null) {
    //   user.updateAll(nameController.text, selectedPicture!);
    // } else if (selectedPicture == null) {
    //   user.updateName(nameController.text);
    // } else if (nameController.text.isEmpty) {
    //   user.updateImg(selectedPicture!);
    // }
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
              controller: nameController,
              onSubmitted: (_) => submitData(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedPicture == null ? 'No picture selected' : 'Selected Picture',
                    ),
                  ),
                  selectedPicture == null
                      ? const SizedBox(
                          width: 10,
                        )
                      : const Icon(
                          AppIcons.addPhoto,
                        ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(AppColors.blue),
                    ),
                    onPressed: startImagePicker,
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
                onPressed: submitData,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
