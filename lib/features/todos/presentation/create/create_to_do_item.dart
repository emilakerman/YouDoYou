import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_repository.dart';
import 'package:youdoyou/features/todos/data/image_picker.dart';
import 'package:youdoyou/features/todos/presentation/create/create_todo_controller.dart';

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
  final TextEditingController _sharedEmailController = TextEditingController();

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
          ("Image is null or invalid");
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
    CreateToDoItemController writeData = ref.read(createToDoItemControllerProvider.notifier);

    writeData.changeState(_titleController.text.characters.toString(), Fields.title);
    writeData.changeState(_descriptionController.text.characters.toString(), Fields.description);
    writeData.changeState(_selectedDate.toString(), Fields.endDate);
    writeData.changeState(ref.watch(authEmailProvider), Fields.author);
    writeData.changeState(
        _sharedEmailController.text.characters.toString().toLowerCase(), Fields.email);
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
        style: TextStyle(color: AppColors.white, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        width: width,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(icon: Icon(Icons.title), labelText: 'Title'),
              controller: _titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.description), labelText: 'Additional information'),
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
            Consumer(builder: (_, ref, __) {
              return ref.watch(toggleSharedProvider)
                  ? TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.share), labelText: 'Receiver Email'),
                      controller: _sharedEmailController,
                    )
                  : const SizedBox.shrink();
            }),
            Row(
              children: [
                IconButton(
                    onPressed: () => _selectImage(ImageSource.camera),
                    icon: const Icon(Icons.add_a_photo)),
                IconButton(
                    onPressed: () => _selectImage(ImageSource.gallery),
                    icon: const Icon(Icons.image)),
                Consumer(
                  builder: (_, ref, __) => Switch(
                    value: ref.watch(toggleSharedProvider),
                    onChanged: (value) => ref.read(toggleSharedProvider.notifier).state = value,
                  ),
                ),
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

enum Fields {
  id,
  title,
  description,
  endDate,
  author,
  image,
  email,
}
