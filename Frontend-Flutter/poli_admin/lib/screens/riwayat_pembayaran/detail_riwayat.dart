import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';

class DetailRiwayat extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const DetailRiwayat(
      {super.key, required this.onMenuPressed, required this.isExpanded});

  @override
  State<DetailRiwayat> createState() => _DetailRiwayatState();
}

class _DetailRiwayatState extends State<DetailRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalTopBar(
        title: 'Rincian Pembayaran',
      ),
      body: Center(
        child: Text('ini detail pembayaran'),
      ),
    );
  }
}
