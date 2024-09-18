import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../screens/add_note_screen.dart';

import '../widgets/footer_app.dart';

class NotasScreen extends StatefulWidget {
  const NotasScreen({super.key});

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

  class _NotasScreenState extends State<NotasScreen> {
    static final _logger = Logger();
    final List<String> _notas = [];

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
                return ListTile(
                  title: Text(_notas[index]),
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddNoteScreen(),
                    ),
                    );
                    if (result != null){
                      setState(() {
                        _notas.add(result);
                      });
                    }
                  },
                child: const Text('Agregar Nota'),
              ),
          ),
        ],
      ),
      bottomNavigationBar:  const FooterApp(),
    );
  }
}