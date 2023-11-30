import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/user_card_form.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);

class _HomeHeaderState extends State<HomeHeader> {
  @override
  void initState() {
    super.initState();
  }

  void _startEditUserCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return UserCardForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, __) {
      final user = ref.watch(userProvider);
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, right: 10),
              height: 90,
              width: 130,
              child: user.profilePicture != ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(user.profilePicture!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      AppIcons.profileIcon,
                      color: Colors.grey,
                      size: 100,
                    ),
            ),
            Card(
              color: AppColors.extra,
              margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 10,
              child: Container(
                height: 100,
                width: 220,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Text(
                              'My ToDos',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              user.name == ''
                                  ? 'User: '
                                  : 'User:      ${user.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
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
            ),
          ],
        ),
      );
    });
  }
}
