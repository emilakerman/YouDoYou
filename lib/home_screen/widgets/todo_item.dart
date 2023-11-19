import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/home_screen/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDoType item;
  const ToDoItem({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    void handleCheck() {}
    void handleDelete() {}

    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            AppIcons.addPhoto,
            color: Colors.grey,
            size: 35,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.description,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(DateFormat.yMMMd().format(item.creationDate)),
            ],
          ),
          Container(
            //margin: EdgeInsets.only(left: 30),
            //decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: item.isDone == false
                      ? Icon(
                          AppIcons.notCheckIcon,
                          color: Colors.grey,
                          size: 35,
                        )
                      : Icon(
                          AppIcons.checkIcon,
                          color: Colors.green,
                          size: 35,
                        ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    AppIcons.deleteIcon,
                    color: Colors.red,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
