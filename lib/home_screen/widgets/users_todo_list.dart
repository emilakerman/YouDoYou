import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class TodoList extends ConsumerStatefulWidget {
  const TodoList({super.key});

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends ConsumerState<TodoList> {
  FirebaseDataService dataService = FirebaseDataService();

  void convertList() async {
    ref.read(listViewProvider.notifier).state = await dataService.loadTodos();
  }

  @override
  void initState() {
    super.initState();
    convertList();
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.read(databaseProvider);
    ref.watch(listViewProvider);
    return Card(
      color: AppColors.complement,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
            width: double.infinity,
            child: Text(
              'To Do List:',
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              itemCount: ref.watch(listViewProvider.notifier).state.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(5),
                  elevation: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Text(ref.watch(listViewProvider.notifier).state[index].title),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
