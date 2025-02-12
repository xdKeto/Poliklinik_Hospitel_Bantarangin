import 'package:flutter/material.dart';

class SidebarItemBox extends StatelessWidget {
  final bool isExpanded;
  final String label;
  const SidebarItemBox(
      {super.key, required this.isExpanded, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? 200 : 0,
      child: Opacity(
        opacity: isExpanded ? 1.0 : 0.0,
        child: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
          ),
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
