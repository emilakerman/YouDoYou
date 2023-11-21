import 'package:flutter/material.dart';

class UserCardForm extends StatefulWidget {
  const UserCardForm({super.key});

  @override
  State<UserCardForm> createState() => _UserCardFormState();
}

class _UserCardFormState extends State<UserCardForm> {
    final _titleController = TextEditingController();

    void _submitData() {
    final enteredName = _titleController.text;

    if (enteredName.isEmpty) {
      return;
    }
    //if im passing the data from parent
    // widget.handleUserName(
    //   name,
    // );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            // 2) add a button that opens up a datepicker
            Container(
              padding: EdgeInsets.only(top: 15),
              child: ElevatedButton(
                style: const ButtonStyle(
                    // foregroundColor: MaterialStatePropertyAll(Colors.white),
                    // backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    ),
                onPressed: _submitData,
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );;
  }
}