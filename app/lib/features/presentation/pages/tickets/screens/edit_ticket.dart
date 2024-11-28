import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/features/domain/entities/enum/StatusEnum.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
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
  late TextEditingController _responseController;
  final EditTicketActions _actions = EditTicketActions();
  List<dynamic> attachedTokens = [];
  Status? _selectedStatus;




  @override
  void initState() {
    super.initState();
    _subjectController = TextEditingController(text: widget.ticket.subject);
    _messageController = TextEditingController(text: widget.ticket.message);
    _responseController = TextEditingController(text: widget.ticket.response ?? '');
    _selectedStatus = widget.ticket.status;
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
    _responseController.dispose();
    attachedTokens.clear();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedStatus == widget.ticket.status) _selectedStatus = Status.IN_PROGRESS;
      final updatedTicket = widget.ticket.copyWith(
        subject: _subjectController.text,
        message: _messageController.text,
        response: _responseController.text.isEmpty ? null : _responseController.text,
        status: _selectedStatus,
      );
      _actions.updateTicket(updatedTicket, () {
        logger.i('Ticket updated');
        initializeTickets();
      });
      Navigator.of(context).pop(updatedTicket);
    }
  }

  void _deleteTicket() {
    // Implement the delete ticket logic here
    _actions.deleteTicket(widget.ticket.token, () {
      logger.i('Ticket deleted');
      deleteTicketfromGlobal(widget.ticket.token);
      Navigator.of(context).pop(true);
      });
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
              IconButton(icon: Icon(AppIcons.delete, weight: 600,color: Theme.of(context).colorScheme.onPrimaryContainer), onPressed: _confirmDeleteTicket,),
              DropdownButtonFormField<Status>(
                value: _selectedStatus,
                decoration: const InputDecoration(labelText: 'Status'),
                items: Status.values.map((Status status) {
                  return DropdownMenuItem<Status>(
                    value: status,
                    child: Text(status.name),
                  );
                }).toList(),
                onChanged: (Status? newValue) {
                  setState(() {
                    _selectedStatus = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a status';
                  }
                  return null;
                },
                icon: const Icon(AppIcons.dropdown, weight: 200),
              ),
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
              TextFormField(
                controller: _responseController, // Nuevo TextFormField
                decoration: const InputDecoration(labelText: 'Response'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a response';
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
                            title: const Text('File Result'),
                            content: Text(fileResult.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Responder'),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this ticket?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteTicket();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

}