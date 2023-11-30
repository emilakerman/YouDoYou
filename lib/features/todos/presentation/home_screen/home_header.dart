import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/authentication/domain/user.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/user_card_form.dart';
import 'package:youdoyou/utils/locally_stored_data.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({super.key});

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

final userProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);

class _HomeHeaderState extends ConsumerState<HomeHeader> {
  // String newName = "";
  // String profilePic = "";
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // This method clears the shared preferences and the providers that contain the user information.
  void clearUserCard() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    ref.read(profilePicProvider.notifier).state = "";
    ref.read(userNameProvider.notifier).state = "";
  }

  void fetchData() async {
    LocallyStoredData data = LocallyStoredData();
    String userName = await data.readName();
    String image = await data.readImage();
    ref.read(profilePicProvider.notifier).state = image;
    ref.read(userNameProvider.notifier).state = userName;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: Sizes.p16, right: Sizes.p12),
          height: 90,
          width: 130,
          child: ref.watch(profilePicProvider) != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.p12),
                  child: Image.file(
                    File(ref.watch(profilePicProvider)),
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  AppIcons.profileIcon,
                  color: AppColors.grey,
                ),
        ),
        Card(
          color: AppColors.extra,
          margin: const EdgeInsets.only(top: Sizes.p16, left: Sizes.p4, right: Sizes.p4),
          child: SizedBox(
            height: 90,
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.p8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          ref.watch(userNameProvider),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.only(top: Sizes.p48),
                  onPressed: () {
                    _startEditUserCard(context);
                  },
                  icon: const Icon(
                    AppIcons.editIcon,
                    color: AppColors.black,
                  ),
                ),
                IconButton(
                    padding: const EdgeInsets.only(top: Sizes.p48),
                    onPressed: () => clearUserCard(),
                    icon: const Icon(
                      Icons.clear,
                      color: AppColors.black,
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final userNameProvider = StateProvider<String>((ref) => "");

final profilePicProvider = StateProvider<String>((ref) => "");
