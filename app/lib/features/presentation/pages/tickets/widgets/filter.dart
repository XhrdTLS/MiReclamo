
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

class FilterWidget extends StatefulWidget{
  final List<Ticket> allSolicitudes;
  final Function(List<Ticket>) onFilterApplied;

  const FilterWidget({super.key, required this.allSolicitudes, required this.onFilterApplied});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget>{
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
    });
  }

  Widget _buildFilterButton(String label, Color color) {
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
              ? const Color.fromARGB(128, 7, 84, 98)
              : color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF04347c),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your filter buttons here
      ],
    );
  }

}




