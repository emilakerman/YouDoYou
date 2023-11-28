import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

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
    Future<void> handleCheck({required WidgetRef ref}) async {
      await ref.read(firestoreRepositoryProvider).updateItem(
          uid: ref.watch(authStateProvider),
          entryId: widget.id,
          entryProperty: !widget.entry.isDone);
    }

    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: NetworkImage(
              widget.entry.image ?? "",
            ),
            width: 30,
            height: 30,
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
                Consumer(
                  builder: (_, ref, __) => IconButton(
                    onPressed: () => ref
                        .read(firestoreRepositoryProvider)
                        .deleteFromFirestore(uid: ref.watch(authStateProvider), id: widget.id),
                    icon: const Icon(
                      AppIcons.deleteIcon,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.go('/detail', extra: {'entry': widget.entry, 'id': widget.id});
                    },
                    icon: const Icon(Icons.edit)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
