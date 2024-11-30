
import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';

class StatusStatCard extends StatelessWidget {
  final String status;
  final String count;
  final Color color;
  final VoidCallback onTap;

  const StatusStatCard({
    super.key,
    required this.status,
    required this.count,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppTheme.lightGray,
            width: 1,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(color: color, width: 8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle, // Placeholder for status icon
                  color: color,
                  size: 25,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status,
                        style: StyleText.header.copyWith(
                          color: color,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        count,
                        style: StyleText.description.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}