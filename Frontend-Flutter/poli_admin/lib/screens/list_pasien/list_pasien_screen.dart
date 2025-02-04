import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class ListPasienScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  const ListPasienScreen({super.key, required this.onMenuPressed});

  @override
  State<ListPasienScreen> createState() => _ListPasienScreenState();
}

class _ListPasienScreenState extends State<ListPasienScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: widget.onMenuPressed,
        ),
      ),
      body: Center(
        child: Text('ini screen list pasien'),
      ),
    );
  }
}
