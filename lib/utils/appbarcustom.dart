import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  const AppBarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.purple,
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );
  }
}
