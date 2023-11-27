import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class ToDoEntry extends StatefulWidget {
  final TodoModel entry;
  const ToDoEntry({required this.entry, super.key});

  @override
  State<ToDoEntry> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoEntry> {
  @override
  Widget build(BuildContext context) {
    FirebaseDataService dataService = FirebaseDataService();

    void handleCheck({required WidgetRef ref}) async {
      ref.read(createToDoItemControllerProvider.notifier).toggleIsDone();
      //dataService.updateTodo();

      // ref.read(listViewProvider.notifier).update((state) => null);
      // final entryProvided = ref.watch(listViewProvider.select((entry) =>
      //     entry.firstWhere((element) => element.id == widget.entry.id)));

      // await db.collection('Todos').doc(widget.entry.id).update({
      //   'isDone': entryProvided.isDone,
      // });
    }

    void handleDelete() {}

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
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
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(
                "${widget.entry.creationDate}",
                // DateFormat.yMMMd().format(widget.entry.creationDate!),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          Container(
            //margin: EdgeInsets.only(left: 30),
            //decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer(
                  builder: (_, ref, __) {
                    final entryProvided = ref.watch(listViewProvider.select(
                        (entry) => entry.firstWhere(
                            (element) => element.id == widget.entry.id)));
                    return IconButton(
                      onPressed: () => handleCheck(ref: ref),
                      //TODO(Any): Update the isDone state.
                      icon: entryProvided.isDone == false
                          ? const Icon(
                              AppIcons.notCheckIcon,
                              color: Colors.grey,
                              size: 35,
                            )
                          : const Icon(
                              AppIcons.checkIcon,
                              color: Colors.green,
                              size: 35,
                            ),
                    );
                  },
                ),
                //TODO(Any): Delete the TODO in Firestore.
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
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
