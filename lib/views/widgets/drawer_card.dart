import 'package:flutter/material.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon});

  final String title;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(
          title
        ),
        leading: Icon(icon),
      ),
    );
  }
}