import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import '../../../../../core/widgets/styles/theme.dart';

class FilterWidget extends StatefulWidget {
  final List<Ticket> allSolicitudes;
  final Function(List<Ticket>) onFilterApplied;

  const FilterWidget({super.key, required this.allSolicitudes, required this.onFilterApplied});

  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  String selectedFilter = 'Todas';
  List<Ticket> filteredSolicitudes = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filteredSolicitudes = widget.allSolicitudes;
  }

  void _changeFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      if (filter == 'Todas') {
        filteredSolicitudes = widget.allSolicitudes;
      } else {
        filteredSolicitudes = widget.allSolicitudes
            .where((solicitud) => solicitud.category.name == filter)
            .toList();
      }
      widget.onFilterApplied(filteredSolicitudes);
    });
  }

  Widget _buildFilterButton(String label) {
    return GestureDetector(
      onTap: () {
        _changeFilter(label);
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.minScrollExtent);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: selectedFilter == label
              ? AppTheme.lightGreen
              : AppTheme.lightStone,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: GoogleFonts.roboto(
            color: selectedFilter == label
                ? AppTheme.darkGreen
                : AppTheme.darkGray,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _scrollController,
      child: Row(
        children: [
          _buildFilterButton('Todas'),
          _buildFilterButton('Reclamos'),
          _buildFilterButton('Sugerencias'),
          _buildFilterButton('Información'),
          // Agregar otros filtros si se necesitan
        ],
      ),
    );
  }
}