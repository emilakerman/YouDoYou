import 'package:flutter/material.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_sizes.dart';

class ReceivedToDoList extends StatelessWidget {
  const ReceivedToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.extra,
      margin: const EdgeInsets.all(Sizes.p12),
      child: Column(
        children: [
          Container(
            height: Sizes.p32,
            width: 290,
            margin: const EdgeInsets.only(top: Sizes.p4),
            decoration: BoxDecoration(
              color: AppColors.extra,
              border: Border.all(color: AppColors.primary, width: 2, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(Radius.circular(Sizes.p12)),
            ),
            child: const Text(
              'Received ToDo List:',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.white,
                fontSize: Sizes.p20,
              ),
            ),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              itemCount: 8,
              itemBuilder: (context, index) {
                return const Card(
                  margin: EdgeInsets.all(Sizes.p4),
                  elevation: 5,
                  child: Row(
                    children: [
                      SizedBox(
                        height: 70,
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 50,
                          color: AppColors.black,
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
