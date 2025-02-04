import 'package:flutter/material.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

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
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: widget.onMenuPressed,
        ),
      ),
      body: const Center(
        child: Text('ini screen billing'),
      ),
    );
  }
}
