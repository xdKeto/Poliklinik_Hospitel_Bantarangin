import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
// import 'package:poli_admin/base/utils/app_styles.dart';

class BillingScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;
  const BillingScreen({super.key, required this.onMenuPressed});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          GlobalTopBar(onMenuPressed: widget.onMenuPressed, title: 'Billing'),
      body: const Center(
        child: Text('ini screen billing'),
      ),
    );
  }
}
