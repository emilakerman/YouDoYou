import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/todos/data/firestore_data_service.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

class DetailScreen extends StatefulWidget {
  final TodoModel? entry;
  final String? id;

  const DetailScreen({Key? key, this.id, this.entry}) : super(key: key);

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
    _descriptionController =
        TextEditingController(text: widget.entry?.description ?? "");
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

  void update() async {
    FirebaseDataService dataService = FirebaseDataService();
    print(widget.entry?.id);
    await dataService
        .editTodoInFirestore(
            title: _titleController.text,
            description: _descriptionController.text,
            id: widget.id,
            endDate: _selectedDate.toString())
        .then((_) {
      context.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gapH32,
            _isEditMode
                ? TextField(controller: _titleController)
                : Text(widget.entry?.title ?? ""),
            Image(image: NetworkImage(widget.entry?.image ?? "")),
            _isEditMode
                ? TextField(controller: _descriptionController)
                : Text(widget.entry?.description ?? ""),
            _isEditMode
                ? TextFormField(
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_month),
                      labelText: 'Select End Date',
                    ),
                    controller: TextEditingController(
                      text: _selectedDate != null
                          ? '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}'
                          : widget.entry?.endDate,
                    ),
                  )
                : Text(widget.entry?.endDate ?? ""),
            Row(
              children: [
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.arrow_back)),
                IconButton(
                    onPressed: () {
                      _toggleEditMode();
                    },
                    icon: const Icon(Icons.edit)),
                _isEditMode
                    ? TextButton(
                        onPressed: () => {update()}, child: const Text("save"))
                    : const SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
