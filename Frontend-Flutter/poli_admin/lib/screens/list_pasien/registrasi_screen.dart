import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class RegistrasiScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const RegistrasiScreen(
      {super.key, required this.onMenuPressed, required this.isExpanded});

  @override
  State<RegistrasiScreen> createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed,
          title: 'Registrasi',
          isExpanded: widget.isExpanded),
      body: Center(
        child: Text('ini registrasi screen'),
      ),
    );
  }
}
