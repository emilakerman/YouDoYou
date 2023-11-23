import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/user_card_form.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  var user = User();

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    // user.getProfilePicture;
    super.initState();
  }

  _getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        user.setProfilePicture = image.path;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', image.path);
    }
  }

  void _startEditUserCard(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return UserCardForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.extra,
      margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 150,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  user.profilePicture != null
                      ? Image.file(
                          File(user.profilePicture!),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        )
                      : const Icon(
                          AppIcons.profileIcon,
                          color: Colors.grey,
                          size: 80,
                        ),
                  IconButton(
                    padding: const EdgeInsets.only(top: 50),
                    onPressed: _getImage,
                    icon: const Icon(
                      AppIcons.editIcon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                  color: AppColors.additional,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text(
                          'UserName',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: const Text('My ToDos'),
                      ),
                    ],
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(top: 50),
                    onPressed: () {
                      _startEditUserCard(context);
                    },
                    icon: const Icon(
                      AppIcons.editIcon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}