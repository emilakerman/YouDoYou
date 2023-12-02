import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/common_widgets/bottom_navigation_buttons.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/home_header.dart';
import 'package:youdoyou/features/todos/presentation/home_screen/users_todo_list.dart';
import 'package:youdoyou/utils/stream_provider.dart';

class Home extends ConsumerWidget {
  final String title = 'Home';
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> logOut() async {
      await FirebaseAuthService().signOut();
    }

    final streamProvider = ref.watch(streamProviderExampleProvider);

    // Schedule the snackbar to appear shortly after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use the condition based on the listener notification
      if (streamProvider.previousCollectionSize > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Todo shared with you!'),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {
                // Optionally, you can add a dismiss action
                // streamProvider.dismissSnackbar(); // Add a method if needed
              },
            ),
          ),
        );
      }

      // Set the widgetBuilt flag to true after the initial build
      streamProvider.widgetBuilt = true;
    });

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
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: logOut,
              icon: const Icon(
                AppIcons.logOutIcon,
                color: AppColors.white,
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
              TodoList(
                title: "To Do List",
                isDone: false,
                isShared: false,
              ),
              TodoList(
                title: "Shared Todos",
                isDone: false,
                isShared: true,
              ),
              TodoList(
                title: "Completed Todos",
                isDone: true,
                isShared: false,
              ),
            ],
          ),
        ),
        floatingActionButton: buildFABRow(context: context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
