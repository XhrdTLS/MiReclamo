import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String note;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(note),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: onDelete,
        ),
      ),
    );
  }
}