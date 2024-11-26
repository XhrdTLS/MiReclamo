import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/actions/actions.dart';

class EditTicketScreen extends StatefulWidget {
  final Ticket ticket;


  const EditTicketScreen({required this.ticket, super.key});

  @override
  _EditTicketScreenState createState() => _EditTicketScreenState();
}

class _EditTicketScreenState extends State<EditTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _subjectController;
  late TextEditingController _messageController;
  final EditTicketActions _actions = EditTicketActions();
  List<dynamic> attachedTokens = [];




  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.ticket.subject);
    _messageController = TextEditingController(text: widget.ticket.message);
    _actions.chargeTicket(widget.ticket.token, (attachedTokens) {
      setState(() {
        this.attachedTokens = attachedTokens;
      });
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    attachedTokens.clear();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Save the updated ticket
      final updatedTicket = widget.ticket.copyWith(
        subject: _subjectController.text,
        message: _messageController.text,
      );
      Navigator.of(context).pop(updatedTicket);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Ticket", isMainScreen: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(labelText: 'Subject'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(labelText: 'Message'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a message';
                  }
                  return null;
                },
              ),
              Wrap(
                children: attachedTokens.map((token) {
                  return IconButton(
                    icon: Icon(AppIcons.file, weight: 800,color: Theme.of(context).colorScheme.onPrimaryContainer),
                    onPressed: () => _actions.fetchAndDisplayFile( widget.ticket.token, token,
                          (fileResult) {
                        // Handle the file result, e.g., display it in a dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('File Result'),
                            content: Text(fileResult.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}