import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32.0, weight: 800),
          const SizedBox(height: 8.0),
          Text(value, style: StyleText.headline),
          const SizedBox(height: 5.0),
          Text(label,style: StyleText.descriptionBold),
        ],
      ),
    );
  }
}