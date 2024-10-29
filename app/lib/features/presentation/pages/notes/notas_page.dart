import 'package:mi_reclamo/core/widgets/barra_app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:mi_reclamo/features/data/models/note.dart';
import 'package:mi_reclamo/features/data/data_sources/local/storage_service.dart';
import 'package:mi_reclamo/core/widgets/widgets.dart';
import 'package:mi_reclamo/features/presentation/pages/notes/widgets/widgets.dart';




class NotasPage extends StatefulWidget {
  const NotasPage({super.key});

  @override
  _NotasPageState createState() => _NotasPageState();
}

class _NotasPageState extends State<NotasPage> {
  static final _logger = Logger();
  final List<Note> _notas = [];

  @override
  void initState() {
    super.initState();
    _refresh();
    _logger.i('Iniciando NotasScreen');

  }

  Future<void> _refresh() async {
    final notes = await StorageService.getNotes();
    setState(() {
      if(mounted){
        _logger.d('Limpiando Notas');
        _notas.clear();
      }
      _logger.d('Notas cargadas: $notes');
      _notas.addAll(notes.map((note)=> Note.fromMap(note)).toList());
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
      await StorageService.saveNotes(_notas.map((note)=> note.toMap()).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BarraApp(titulo: 'Notas'),
      drawer: MenuApp(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: _notas.length,
                itemBuilder: (context, index) {
                  return NoteCard(
                    note: _notas[index],
                    onDelete: () {
                      setState(() {
                        _notas.removeAt(index);
                      });
                      StorageService.saveNotes(_notas.map((note)=> note.toMap()).toList());
                    },
                  );
                },
              ),
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
      bottomNavigationBar: const FooterApp(),
    );
  }

  @override
  void dispose() {
    _logger.i('Cerrando NotasScreen');
    _notas.clear();
    super.dispose();
  }

}