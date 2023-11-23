import 'package:flutter/material.dart';
import 'package:youdoyou/common_widgets/bottom_navigation_buttons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home_header.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/received_todo_list.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/users_todo_list.dart';

class Home extends StatelessWidget {
  final String title = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: AppColors.complement,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              TodoList(title: "To Do List", isDone: false),
              TodoList(title: "Completed Todos", isDone: true),
              // TodoList(title: "Received Todos"),
            ],
          ),
        ),
        floatingActionButton: buildFABRow(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
