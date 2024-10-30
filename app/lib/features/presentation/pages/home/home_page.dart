import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
    padding: EdgeInsets.all(16),
    child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopNavigation(titulo: "Home Page"),
             SizedBox(height: 20),
             SizedBox(height: 20),
             SizedBox(height: 20),
          ],
        ),
      ),
    );
  } 
 }