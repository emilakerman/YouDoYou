import 'package:flutter/material.dart';
import 'package:youdoyou/common_widgets/bottom_navigation_buttons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home_header.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/users_todo_list.dart';

class Home extends StatelessWidget {
  final String title = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    
    // TEMPORARY LOG OUT
    Future<void> _logOut() async {
      await FirebaseAuthService().signOut();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.extra),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: _logOut,
              icon: const Icon(
                AppIcons.logOutIcon,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
          backgroundColor: AppColors.complement,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              TodoList(title: "To Do List", isDone: false),
              TodoList(title: "Completed Todos", isDone: true),
              //TODO(Any): Implement new collection in firestore with shared todos and add to this widget.
            ],
          ),
        ),
        floatingActionButton: buildFABRow(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
