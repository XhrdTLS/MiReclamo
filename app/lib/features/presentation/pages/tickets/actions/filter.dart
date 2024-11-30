import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';

class FilterWidget extends StatelessWidget {
  final Function(String?) onCategoryChanged;
  final Logger _logger = Logger();

  FilterWidget({super.key, required this.onCategoryChanged});

  void _changeFilter(String filter) {
    onCategoryChanged(filter == 'TODAS' ? null : filter);
    _logger.i('Filter changed to $filter');
  }

  Widget _buildFilterButton(String label, Color color) {
    return GestureDetector(
      onTap: () => _changeFilter(label),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: StyleText.label.copyWith(
            color: AppTheme.darkGray,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding (
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            'Filtrar por:',
            style: StyleText.body,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              _buildFilterButton('TODAS', AppTheme.lightGray),
              _buildFilterButton('CLAIM', AppTheme.lightOrange),
              _buildFilterButton('SUGGESTION', AppTheme.lightGreen),
              _buildFilterButton('INFORMATION', AppTheme.lightBlue),
            ],
          ),
          const SizedBox(height: 5),
          Text('Solicitudes', style: StyleText.body),
        ],
      ),),
    );
  }
}