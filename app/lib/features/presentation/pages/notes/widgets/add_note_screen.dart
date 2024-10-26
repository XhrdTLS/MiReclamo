import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/models/note.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final Uuid _uuid = const Uuid();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Nota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Contenido'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
                  final newNote = Note(
                    id: _uuid.v4(),
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                  Navigator.pop(context, newNote);
                }
              },
              child: const Text('Guardar Nota'),
            ),
          ],
        ),
      ),
    );
  }
}