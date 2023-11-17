import 'package:flutter/material.dart';
import 'package:youdoyou/common_widgets/bottom_navigation_buttons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/home_screen/widgets/home_header.dart';
import 'package:youdoyou/home_screen/widgets/received_todo_list.dart';
import 'package:youdoyou/home_screen/widgets/users_todo_list.dart';

class Home extends StatelessWidget {
  final String title = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'YouDoYou',
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
        body: Column(
          children: [
            HomeHeader(),
            TodoList(),
            ReceivedToDoList(),
            Text('Bottom navigator'),
          ],
        ),
        floatingActionButton: buildFABRow(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
