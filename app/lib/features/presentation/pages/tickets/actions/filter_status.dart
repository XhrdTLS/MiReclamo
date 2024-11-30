
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';

class FilterStatus extends StatelessWidget {
  final Function(String?) onStatusChanged;
  final Logger _logger = Logger();

  FilterStatus({super.key, required this.onStatusChanged});

  void _changeFilter(String filter) {
    globalStatusFilter = filter == 'TODOS' ? null : filter;
    onStatusChanged(globalStatusFilter);
    _logger.i('Status filter changed to $filter');
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Filtrar por Estado:',
              style: StyleText.body,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                _buildFilterButton('TODOS', AppTheme.lightStone),
                _buildFilterButton('ERROR', AppTheme.lightRed),
                _buildFilterButton('UNDER_REVIEW', AppTheme.lightYellow),
                _buildFilterButton('IN_PROGRESS', AppTheme.lightBlue),
                _buildFilterButton('PENDING_INFORMATION', AppTheme.lightGray),
                _buildFilterButton('RESOLVED', AppTheme.lightGreen),
                _buildFilterButton('CLOSED', AppTheme.lightRed),
                _buildFilterButton('CANCELLED', AppTheme.lightRed),
              ],
            ),
          ],
        ),
      ),
    );
  }
}