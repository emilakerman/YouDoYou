import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/data/image_picker.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class CreateItemWidget extends StatefulWidget {
  const CreateItemWidget({super.key});

  @override
  State<CreateItemWidget> createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {
  File? _image;
  DateTime? _selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectImage(ImageSource source) async {
    try {
      File? img = await pickImage(source);
      if (img != null) {
        setState(() {
          _image = img;
        });
      } else {
        if (kDebugMode) {
          print("Image is null or invalid");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
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

  void _setTodoObject({required WidgetRef ref}) {
    ref
        .read(createToDoItemControllerProvider.notifier)
        .changeTitle(_titleController.text.characters.toString());
    ref
        .read(createToDoItemControllerProvider.notifier)
        .changeDescription(_descriptionController.text.characters.toString());
    ref.read(createToDoItemControllerProvider.notifier).changeEndDate(_selectedDate.toString());
    ref.read(createToDoItemControllerProvider.notifier).changeAuthor(ref.watch(authStateProvider));
    ref.watch(createToDoItemControllerProvider);
  }

  Future<void> _createTodoItem({required WidgetRef ref}) async {
    _setTodoObject(ref: ref);
    await ref
        .read(firestoreRepositoryProvider)
        .addTodo(ref, _image, ref.watch(authStateProvider))
        .then((_) {
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppColors.secondary,
      scrollable: true,
      title: const Text(
        "Create Todo",
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: width,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.title), labelText: 'Title'),
              controller: _titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.description), labelText: 'Description'),
              controller: _descriptionController,
            ),
            TextFormField(
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_month),
                labelText: 'Select End Date',
              ),
              controller: TextEditingController(
                text: _selectedDate != null
                    ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                    : '',
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () => _selectImage(ImageSource.camera),
                    icon: const Icon(Icons.add_a_photo)),
                IconButton(
                    onPressed: () => _selectImage(ImageSource.gallery),
                    icon: const Icon(Icons.image))
              ],
            ),
            _image != null
                ? Image.file(
                    _image!,
                    width: 60,
                    height: 60,
                  )
                : const SizedBox.shrink()
          ],
        )),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(),
          child: const Text('Cancel'),
        ),
        Consumer(
          builder: (_, ref, __) => ElevatedButton(
            onPressed: () {
              _createTodoItem(ref: ref);
            },
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
