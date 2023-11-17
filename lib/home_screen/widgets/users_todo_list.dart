import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.complement,
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
            width: double.infinity,
            child: Text('To Do List:', textAlign: TextAlign.center,),
            ),
          SizedBox(
            height: 270,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Card(
                  margin: EdgeInsets.all(5),
                  elevation: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Icon(Icons.add_a_photo_outlined,
                        size: 50,
                        color: Colors.black,
                        ),
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