import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  bool isPicture = true;
  File? _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadImageFromPreferences();
  }

  _loadImageFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imagePath = prefs.getString('imagePath') ?? '';
    if (imagePath.isNotEmpty) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  _saveImageToPreferences(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imagePath', imagePath);
  }

  _getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
      _saveImageToPreferences(image.path);
    }
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
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //PROFILE PICTURE
            Container(
              //without this size, it would be as big as children
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
                  _imageFile != null
                      ? Image.file(
                          _imageFile!,
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
                    padding: EdgeInsets.only(top: 50),
                    onPressed: _getImage,
                    icon: const Icon(
                      AppIcons.editIcon,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //USER CARD
            Container(
              height: 90,
              width: 200,
              decoration: BoxDecoration(
                  color: AppColors.additional,
                  border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              //margin: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        //height: 30,
                        //width: 100,
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'UserName',
                        ),
                      ),
                      Container(
                        //height: 30,
                        //width: 100,
                        padding: EdgeInsets.only(left: 10),
                        child: Text('My ToDos'),
                      ),
                    ],
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 50),
                    onPressed: () {},
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
