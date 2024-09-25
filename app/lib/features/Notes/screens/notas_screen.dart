import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'add_note_screen.dart';
import '../widgets/note_card.dart';

import '../../../services/storage_service.dart';
import '../../../widgets/footer_app.dart';

class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

  class _NotasScreenState extends State<NotasScreen> {
    static final _logger = Logger();
    final List<String> _notas = [];

    @override
    void initState() {
      super.initState();
      _loadNotes();
      _logger.i('Iniciando NotasScreen');
    }

    Future<void> _loadNotes() async {
      _logger.i('Cargando Notas');
      final notes = await StorageService.getNotes();
      setState(() {
        _notas.addAll(notes);
      });
    }

    Future<void> _addNote() async {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNoteScreen(),
        ),
      );
      if (result != null) {
        setState(() {
          _notas.add(result);
        });
        await StorageService.saveNotes(_notas);
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _notas.length,
              itemBuilder: (context, index){
                return NoteCard(
                  note: _notas[index],
                  onDelete: () {
                    setState(() {
                      _notas.removeAt(index);
                    });
                    StorageService.saveNotes(_notas);
                  },
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _addNote,
                child: const Text('Agregar Nota'),
              ),
          ),
        ],
      ),
      bottomNavigationBar:  const FooterApp(),
    );
  }
}