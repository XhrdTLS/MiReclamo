import  'package:mi_reclamo/features/presentation/pages/views.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteCard({
    required this.note,
    required this.onDelete,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: onDelete,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context)=> const HomePage())
          );
        },
      ),
    );
  }
}

