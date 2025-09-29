import 'package:flutter/material.dart';
import 'package:notesapp/Widget/custom_text_field.dart';


class CreateNotePage extends StatefulWidget {
  const CreateNotePage({super.key});

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  @override
  Widget build(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note',
            style: TextStyle(
                color: const Color.fromARGB(255, 232, 229, 233),
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  hintText: 'Enter Title',
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  controller: titleController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  hintText: 'Enter description',
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: descController,
                ),
              ],
            ),
          ),
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.trim().isEmpty || descController.text.trim().isEmpty) {
            _showError('Title and Description cannot be empty');
            return;
          }
          final note = {
            'title': titleController.text,
            'description': descController.text,
          };
          Navigator.pop(context, note);
        },
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}

// ...existing code...
