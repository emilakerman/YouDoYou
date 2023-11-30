import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';
import 'package:youdoyou/routing/routes.dart';

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

    return Container(
      height: 80,
      //width: double.infinity,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
  //image--------------------------------------------------
          Container(
            //alignment: Alignment.topCenter,
            padding: EdgeInsets.only(left:4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: NetworkImage(
                  widget.entry.image ?? "",
                ),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
          ),
 //title,descript,date----------------------------------------         
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.entry.title,
                    style: const TextStyle(
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold),
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
//Buttons----------------------------------------------
          Container(
            //alignment: Alignment(-1, -1),
            //alignment: AlignmentDirectional.topEnd,
            child: Row(
              children: [
                Consumer(
                  builder: (_, ref, __) {
                    return IconButton(
                      onPressed: () => handleCheck(ref: ref),
                      icon: widget.entry.isDone == false
                          ? const Icon(
                              AppIcons.notCheckIcon,
                              color: Colors.grey,
                              size: 30,
                            )
                          : const Icon(
                              AppIcons.checkIcon,
                              color: Colors.green,
                              size: 30,
                            ),
                    );
                  },
                ),
                Consumer(
                  builder: (_, ref, __) {
                    return IconButton(
                      onPressed: () => ref
                          .read(firestoreRepositoryProvider)
                          .deleteFromFirestore(
                              uid: ref.watch(authStateProvider), id: widget.id),
                      icon: const Icon(
                        AppIcons.deleteIcon,
                        color: Colors.red,
                        size: 30,
                      ),
                    );
                  },
                ),
                IconButton(
                    onPressed: () {
                      context.go('/detail',
                          extra: {'entry': widget.entry, 'id': widget.id});
                    },
                    icon: const Icon(AppIcons.editIcon)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//border style

            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.black),
            //   borderRadius: const BorderRadius.all(
            //     Radius.circular(2),
            //   ),
            // ),