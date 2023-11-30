import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_repository.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

class ToDoEntry extends StatefulWidget {
  final TodoModel entry;
  final String id;

  const ToDoEntry({
    required this.entry,
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<ToDoEntry> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoEntry> {
  Future<void> handleCheck({required WidgetRef ref}) async {
    await ref.read(firestoreRepositoryProvider).updateItem(
          uid: ref.watch(authStateProvider),
          entryId: widget.id,
          entryProperty: !widget.entry.isDone,
          entry: widget.entry,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: [
          // Image
          Container(
            padding: const EdgeInsets.only(left: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(widget.entry.image ?? ""),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
          // Title, Description, Date
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.entry.title,
                    style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.entry.description,
                    style: const TextStyle(
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${widget.entry.creationDate}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer(
                builder: (_, ref, __) {
                  return IconButton(
                    onPressed: () => handleCheck(ref: ref),
                    icon: widget.entry.isDone == false
                        ? const Icon(
                            AppIcons.notCheckIcon,
                            color: AppColors.grey,
                            size: 30,
                          )
                        : const Icon(
                            AppIcons.checkIcon,
                            color: AppColors.green,
                            size: 30,
                          ),
                  );
                },
              ),
              Consumer(
                builder: (_, ref, __) => IconButton(
                  onPressed: () => ref.read(firestoreRepositoryProvider).deleteFromFirestore(
                      uid: ref.watch(authStateProvider), id: widget.id, entry: widget.entry),
                  icon: const Icon(
                    AppIcons.deleteIcon,
                    color: AppColors.red,
                    size: 30,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  context.go('/detail', extra: {'entry': widget.entry, 'id': widget.id});
                },
                icon: const Icon(AppIcons.editIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
