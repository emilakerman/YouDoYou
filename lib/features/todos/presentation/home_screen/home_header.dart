import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/user_card_form.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({super.key});

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

// final userProvider = StateNotifierProvider<UserNotifier, User>(
//   (ref) => UserNotifier(),
// );

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  final authManager = FirebaseAuthService();
  

  @override
  void initState() {
    super.initState();
    //ref.watch(userProvider.select((value) => value.setInitState()));
  }

  void _startEditUserCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return const UserCardForm();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final user = ref.watch(userProvider);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15, right: 10),
              height: 90,
              width: 130,
              child: user.profilePicture != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(user.profilePicture!),
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(
                      AppIcons.profileIcon,
                      color: AppColors.extra,
                      size: 100,
                    ),
            ),
            Card(
              color: AppColors.extra,
              margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
              elevation: 10,
              child: SizedBox(
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
                          const Padding(
                            padding: EdgeInsets.only(left: 50),
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
                              //replace '' by null when error is found
                              user.name == ''
                                  ? 'User:    empty.'
                                  : 'User:    ${user.name}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              overflow: TextOverflow.clip,
                              'Email:   ${authManager.getUser()?.email?.substring(0, 12) ?? 'Email:  empty.'}',
                              style: const TextStyle(
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
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
