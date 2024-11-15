import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/styles/style_text.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}