import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';

class FilterTipo extends StatelessWidget {
  final Function(String?) onCategoryChanged;
  final Logger _logger = Logger();

  FilterTipo({super.key, required this.onCategoryChanged});

  void _changeFilter(String filter) {
    globalCategoryFilter = filter == 'TODAS' ? null : filter;
    onCategoryChanged(globalCategoryFilter);
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
      child: Row(
        children: [
          _buildFilterButton('TODAS', AppTheme.lightStone),
          _buildFilterButton('CLAIM', AppTheme.lightOrange),
          _buildFilterButton('SUGGESTION', AppTheme.lightGreen),
          _buildFilterButton('INFORMATION', AppTheme.lightBlue),
        ],
      ),
    );
  }
}