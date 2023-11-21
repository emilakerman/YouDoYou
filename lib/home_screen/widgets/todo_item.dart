import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/home_screen/models/todo_item.dart';

class ToDoEntry extends StatefulWidget {
  final ToDoItem entry;
  const ToDoEntry({required this.entry, super.key});

  @override
  State<ToDoEntry> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoEntry> {
  @override
  Widget build(BuildContext context) {
    void handleCheck() {
      setState(() {
        widget.entry.isDone = !widget.entry.isDone;
      });
    }
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
                widget.entry.description,
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(
                DateFormat.yMMMd().format(widget.entry.creationDate!),
                style: TextStyle(fontSize: 15),
                ),
            ],
          ),
          Container(
            //margin: EdgeInsets.only(left: 30),
            //decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: handleCheck,
                  icon: widget.entry.isDone == false
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
