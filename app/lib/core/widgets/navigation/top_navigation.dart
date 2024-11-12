import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';

class TopNavigation extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isMainScreen;

  const TopNavigation({
    super.key,
    required this.title,
    this.isMainScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: isMainScreen
          ? Container()
          : IconButton(
              icon: Icon(AppIcons.back, weight: 800, color: Theme.of(context).colorScheme.onPrimaryContainer),
              onPressed: () => Navigator.of(context).pop(),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}