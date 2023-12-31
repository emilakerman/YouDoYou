import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';
import 'package:youdoyou/features/todos/presentation/home/todo_entry.dart';

class TodoList extends ConsumerStatefulWidget {
  final String title;
  final bool isDone;
  final bool isShared;
  const TodoList({
    super.key,
    required this.title,
    required this.isDone,
    required this.isShared,
  });

  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends ConsumerState<TodoList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> todoStream = FirebaseFirestore.instance
        .collection('Users')
        .doc(ref.watch(authStateProvider))
        .collection("Todos")
        .where('isDone', isEqualTo: false)
        .snapshots();

    final Stream<QuerySnapshot> todoStreamIsDone = FirebaseFirestore.instance
        .collection('Users')
        .doc(ref.watch(authStateProvider))
        .collection("Todos")
        .where('isDone', isEqualTo: true)
        .snapshots();

    // Stream that listens to a shared collection where email = current user email.
    final Stream<QuerySnapshot> sharedStream = FirebaseFirestore.instance
        .collection('Shared')
        .where('email', isEqualTo: ref.watch(authEmailProvider))
        .snapshots();

    return Card(
      color: AppColors.complement,
      margin: const EdgeInsets.all(Sizes.p12),
      child: SingleChildScrollView(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: Sizes.p20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 230,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length ?? 0,
                    itemBuilder: (context, index) {
                      if (snapshot.data?.docs.isEmpty ?? true) {
                        return const CircularProgressIndicator();
                      }

                      List<DocumentSnapshot<Map<String, dynamic>>> sortedDocs =
                          snapshot.data!.docs.cast<DocumentSnapshot<Map<String, dynamic>>>();
                      sortedDocs.sort((a, b) {
                        // Convert strings to DateTime for proper sorting
                        DateTime aTime = DateTime.parse(a['id']);
                        DateTime bTime = DateTime.parse(b['id']);
                        return bTime.compareTo(aTime);
                      });

                      DocumentSnapshot<Map<String, dynamic>> document = sortedDocs[index];

                      return Card(
                        margin: const EdgeInsets.all(Sizes.p4),
                        elevation: 5,
                        child: ToDoEntry(
                          id: document.id,
                          entry: TodoModel.fromDocumentSnapshot(document),
                        ),
                      );
                    },
                  );
                },
                stream: widget.isShared
                    ? sharedStream
                    : widget.isDone
                        ? todoStreamIsDone
                        : todoStream,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
