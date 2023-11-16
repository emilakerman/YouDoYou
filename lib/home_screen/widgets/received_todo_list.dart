import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';

class ReceivedToDoList extends StatelessWidget {
  const ReceivedToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.extra,
      child: Column(
        children: [
          Container(
            height: 30,
            width: double.infinity,
            child: Text('Received ToDo List:', textAlign: TextAlign.center,),
            ),
          Container(
            height: 230,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Container(
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