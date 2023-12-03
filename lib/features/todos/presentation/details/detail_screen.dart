import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:youdoyou/constants/app_colors.dart';
import 'package:youdoyou/constants/app_icons.dart';
import 'package:youdoyou/constants/app_sizes.dart';
import 'package:youdoyou/features/authentication/data/firebase_auth.dart';
import 'package:youdoyou/features/todos/data/firestore_data_repository.dart';
import 'package:youdoyou/features/todos/domain/todo_model.dart';

class DetailScreen extends StatefulWidget {
  final TodoModel? entry;
  final String? id;

  const DetailScreen({super.key, this.id, this.entry});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
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

  String formatCustomDateString(String? dateString) {
    if (dateString != null) {
      DateTime? date = DateTime.tryParse(dateString);
      if (date != null) {
        return DateFormat('EEEE, d MMMM').format(date);
      }
    }
    return ''; // Handle the case where parsing fails or the date string is null
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
            style:
                const TextStyle(color: AppColors.white, fontSize: 30, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          widget.entry?.email == ""
              ? IconButton(
                  onPressed: _toggleEditMode,
                  icon: const Icon(
                    AppIcons.editIcon,
                    color: AppColors.white,
                    size: 30,
                  ),
                )
              : const SizedBox.shrink(),
        ],
        backgroundColor: AppColors.complement,
      ),
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Shadow color
                    spreadRadius: 2, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: const Offset(0, 2), // Offset in the x, y direction
                  ),
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image(
                    image: NetworkImage(widget.entry?.image ?? ""),
                    fit: BoxFit.cover,
                  )),
            ),
            //here
            gapH12,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Card(
                color: AppColors.secondary,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      _isEditMode
                          ? TextField(controller: _titleController)
                          : Text("${widget.entry?.title}",
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                      _isEditMode
                          ? TextField(controller: _descriptionController)
                          : Text("${widget.entry?.description}",
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
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
                          : Text("Do before: ${formatCustomDateString(widget.entry?.endDate)}",
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                      widget.entry?.email != ""
                          ? Text("Author: ${widget.entry?.author}",
                              style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold))
                          : const SizedBox.shrink(),

                      //here
                      Consumer(
                        builder: (context, ref, child) => Row(
                          children: [
                            _isEditMode
                                ? ElevatedButton(
                                    style: const ButtonStyle(),
                                    onPressed: () => {update(ref)},
                                    child: const Text('Save'),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
