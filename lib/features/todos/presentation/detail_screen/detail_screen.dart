import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_repository.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

class DetailScreen extends StatefulWidget {
  final TodoModel? entry;
  final String? id;

  const DetailScreen({super.key, this.id, this.entry});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isEditMode = false;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = parseDateStringToDate();
    _titleController = TextEditingController(text: widget.entry?.title ?? "");
    _descriptionController = TextEditingController(text: widget.entry?.description ?? "");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  DateTime parseDateStringToDate() {
    DateTime dateTime = DateTime.parse(widget.entry!.endDate);
    return dateTime;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  void update(WidgetRef ref) async {
    await ref
        .read(firestoreRepositoryProvider)
        .editTodoInFirestore(
          title: _titleController.text,
          description: _descriptionController.text,
          id: widget.id,
          endDate: _selectedDate.toString(),
          uid: ref.watch(authStateProvider),
        )
        .then((_) {
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.entry?.title ?? "Title",
            style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _toggleEditMode,
            icon: const Icon(
              AppIcons.editIcon,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: AppColors.complement,
      ),
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(widget.entry?.image ?? ""),
                  fit: BoxFit.cover,
                )),
            _isEditMode
                ? TextField(controller: _titleController)
                : Text(widget.entry?.title ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            _isEditMode
                ? TextField(controller: _descriptionController)
                : Text(widget.entry?.description ?? "",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            _isEditMode
                ? TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: const InputDecoration(
                      icon: Icon(AppIcons.calendarIcon),
                      labelText: 'Select End Date',
                    ),
                    controller: TextEditingController(
                      text: _selectedDate != null
                          ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                          : widget.entry?.endDate,
                    ),
                  )
                : Text(widget.entry?.endDate ?? ""),
            Consumer(
              builder: (context, ref, child) => Row(
                children: [
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
                  IconButton(
                      onPressed: () {
                        _toggleEditMode();
                      },
                      icon: const Icon(Icons.edit)),
                  _isEditMode
                      ? TextButton(onPressed: () => {update(ref)}, child: const Text("save"))
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
