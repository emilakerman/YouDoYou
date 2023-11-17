import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/presentation/create_todo_controller.dart';

class CreateItemWidget extends StatefulWidget {
  const CreateItemWidget({super.key});

  @override
  State<CreateItemWidget> createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {
  Uint8List? _image;
  DateTime? _selectedDate;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
    if (kDebugMode) {
      print("No image selected");
    }
  }

  void _selectImage() async {
    try {
      Uint8List? img = await pickImage(ImageSource.gallery);
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

  void _selectCamera() async {
    try {
      Uint8List? img = await pickImage(ImageSource.camera);
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

//TODO(ANY): put this function in utils.
  String getTodaysDate() {
    DateTime today = DateTime.now();
    return "${today.year}-${today.month}-${today.day}";
  }

  Future<void> _createTodoItem({required ref}) async {
    FirebaseDataService dataService = FirebaseDataService();
    dataService.addTodo();
    if (kDebugMode) {
      // print(_titleController.text.characters);
      //keep this commented below
      // ref
      //     .read(createToDoItemControllerProvider.notifier)
      //     .changeTitle(_titleController.text.characters.toString());
      // print(ref.watch(createToDoItemControllerProvider.select((value) => value.title)));
    }
    if (kDebugMode) {
      // print(_descriptionController.text.characters);
    }
    if (kDebugMode) {
      // print(_selectedDate);
    }
    if (kDebugMode) {
      // print(getTodaysDate());
    }
    //TODO(Any): create function to create item and save to firebase
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      scrollable: true,
      title: const Text("Create Todo"),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(icon: Icon(Icons.cabin), labelText: 'Title'),
              controller: _titleController,
            ),
            TextFormField(
              decoration: const InputDecoration(icon: Icon(Icons.note), labelText: 'Description'),
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
                IconButton(onPressed: _selectCamera, icon: const Icon(Icons.add_a_photo)),
                IconButton(onPressed: _selectImage, icon: const Icon(Icons.image))
              ],
            ),
            _image != null
                ? Image(image: MemoryImage(_image!), width: 60, height: 60)
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