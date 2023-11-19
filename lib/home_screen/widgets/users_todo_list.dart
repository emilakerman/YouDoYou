import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';
import 'package:youdoyou/home_screen/models/todo.dart';
import 'package:youdoyou/home_screen/widgets/todo_item.dart';

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

  List<ToDoType> itemsList = [
    ToDoType(title: 'test1', description: 'do this and that', creationDate: DateTime.now(), author: 'joel'),
    ToDoType(title: 'test2', description: 'do this and that', isDone: true, creationDate: DateTime.now(), author: 'joel'),
  ];

  @override
  Widget build(BuildContext context) {
    ref.watch(listViewProvider);
    return Card(
      color: AppColors.complement,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            height: 30,
            width: 290,
            margin: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: AppColors.extra,
              border: Border.all(
                color: AppColors.primary, 
                width: 2, 
                style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            child: const Text(
              'To Do List:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                ),
            ),
          ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              //itemCount: ref.watch(listViewProvider.notifier).state.length,
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(5),
                  elevation: 5,
                  child: ToDoItem(item: itemsList[index],),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
