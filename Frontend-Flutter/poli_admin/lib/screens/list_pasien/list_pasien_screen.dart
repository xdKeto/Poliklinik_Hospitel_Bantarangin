import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
// import 'package:poli_admin/base/utils/app_styles.dart';

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
      appBar: GlobalTopBar(onMenuPressed: widget.onMenuPressed, title: 'List Pasien'),
      body: Center(
        child: Text('ini screen list pasien'),
      ),
    );
  }
}
