import 'package:mi_reclamo/core/core.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteCard({
    required this.note,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: IconButton(
          icon: const Icon(AppIcons.delete),
          onPressed: onDelete,
        ),
        onTap: () {
          Navigator.pop(
            context,
          );
        },
      ),
    );
  }
}

