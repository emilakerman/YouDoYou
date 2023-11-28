import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class ToDoEntry extends StatefulWidget {
  final TodoModel entry;
  final String id;
  const ToDoEntry({required this.entry, super.key, required this.id});

  @override
  State<ToDoEntry> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoEntry> {
  @override
  Widget build(BuildContext context) {
    FirebaseDataService dataService = FirebaseDataService();

    Future<void> handleCheck({required WidgetRef ref}) async {
      // ref.read(createToDoItemControllerProvider.notifier).toggleIsDone();

      // final entryProvided = ref
      //     .watch(listViewProvider.notifier)
      //     .state
      //     .firstWhere((element) => element.id == widget.entry.id);
      // final entryIndex = ref
      //     .watch(listViewProvider.notifier)
      //     .state
      //     .indexWhere((element) => element.id == widget.entry.id);
      // print('widget entry ${widget.entry.isDone}');
      // print('entry id from ref ${entryProvided.id}');
      // print('entry index $entryIndex');

      // if (widget.id != null) {
      await dataService.updateItem(entryId: widget.id, entryProperty: !widget.entry.isDone);
      // }
    }

    // FirebaseDataService dataService = FirebaseDataService();

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(image: NetworkImage(widget.entry.image ?? "")),
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
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Consumer(
                  builder: (_, ref, __) {
                    // final entryProvided = ref.watch(listViewProvider.select(
                    //     (entry) => entry.firstWhere((element) => element.id == widget.entry.id)));
                    return IconButton(
                      onPressed: () => handleCheck(ref: ref),
                      icon: widget.entry.isDone == false
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
                IconButton(
                  onPressed: () => dataService.deleteFromFirestore(widget.id),
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
