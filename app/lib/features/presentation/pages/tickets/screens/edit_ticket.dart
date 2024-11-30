import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/enum/StatusEnum.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/actions/actions.dart';
import '../widgets/widgets.dart';
import 'package:intl/intl.dart';

class EditTicketScreen extends StatefulWidget {
  final Ticket ticket;

  const EditTicketScreen({required this.ticket, super.key});

  @override
  EditTicketScreenState createState() => EditTicketScreenState();
}

class EditTicketScreenState extends State<EditTicketScreen> {
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
    _responseController =
        TextEditingController(text: widget.ticket.response ?? '');
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
      if (_selectedStatus == widget.ticket.status)
        _selectedStatus = Status.IN_PROGRESS;
      final updatedTicket = widget.ticket.copyWith(
        subject: _subjectController.text,
        message: _messageController.text,
        response:
            _responseController.text.isEmpty ? null : _responseController.text,
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
    String idTicket = widget.ticket.token.toString();
    String tipo = widget.ticket.type.name;
    String asunto = widget.ticket.subject;
    String estado = widget.ticket.status.name;
    String categoria = widget.ticket.category.name;
    DateTime fechaCreado = widget.ticket.created;
    DateTime fechaActualizado = widget.ticket.updated;

    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: const TopNavigation(title: "Ticket", isMainScreen: false),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IDENTIFICADOR DEL TICKET
                Text(idTicket, style: StyleText.labelSmall),
                const SizedBox(height: 8),
                // ASUNTO DEL TICKET
                Text(
                  asunto,
                  style: StyleText.headline,
                ),
                // CATEGORÍA DEL TICKET
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('Categoría: ', style: StyleText.label),
                    Text(
                        categoria,
                        style: StyleText.label.copyWith(
                          color: getTipoTextColor(tipo),
                        ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // TIPO DE TICKET
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: getTipoColor(context, tipo),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              getTipoIcon(tipo),
                              weight: 700,
                              color: getTipoTextColor(tipo),
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tipo,
                              style: StyleText.label.copyWith(
                                color: getTipoTextColor(tipo),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(width: 8),
                    // ESTADO DEL TICKET
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: getEstadoColor(estado),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        estado,
                        style: StyleText.label.copyWith(
                          color: getEstadoTextColor(estado),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Fecha de Creación', style: StyleText.label),
                const SizedBox(height: 8),
                Text(
                  formatter.format(fechaCreado),
                  style: StyleText.body,
                ),
                const SizedBox(height: 8),
                Text('Fecha de Actualización', style: StyleText.label),
                const SizedBox(height: 8),
                Text(
                  formatter.format(fechaActualizado),
                  style: StyleText.body,
                ),
                // CAMBIAR ESTADO DEL TICKET
                const SizedBox(height: 20),
                Text('Cambiar Estado', style: StyleText.label),
                const SizedBox(height: 8),
                DropdownButtonFormField<Status>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  value: _selectedStatus,
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
                  icon: const Icon(AppIcons.dropdown, weight: 400),
                ),
                const SizedBox(height: 12),
                // DESCRIPCIÓN DEL TICKET
                Text('Descripción', style: StyleText.label),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    _messageController.text,
                    style: StyleText.body,
                  ),
                ),
                const SizedBox(height: 12),
                // RESPUESTA DEL TICKET
                Text('Responder', style: StyleText.label),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _responseController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Escribe la Respuesta',
                      hintStyle: StyleText.body.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Debes Ingresar una Respuesta';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  children: attachedTokens.map((token) {
                    return IconButton(
                      icon: Icon(AppIcons.file,
                          weight: 800,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                      onPressed: () => _actions.fetchAndDisplayFile(
                        widget.ticket.token,
                        token,
                        (fileResult) {
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: TextButton(
                        onPressed: _confirmDeleteTicket,
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.lightStone,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        ),
                        child: Text('Eliminar Ticket', style: StyleText.label.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      child: TextButton(
                        onPressed: _saveForm,
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                        ),
                        child: Text('Responder Ticket', style: StyleText.label.copyWith(color: Theme.of(context).colorScheme.onSurface)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDeleteTicket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Definitivamente'),
        content: const Text('¿Deseas eliminar el ticket definitivamente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteTicket();
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}