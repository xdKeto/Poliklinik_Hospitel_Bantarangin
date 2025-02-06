import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/global_top_bar.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class DetailBilling extends StatefulWidget {
  final VoidCallback onMenuPressed;
  final bool isExpanded;
  const DetailBilling(
      {super.key, required this.onMenuPressed, required this.isExpanded});

  @override
  State<DetailBilling> createState() => _DetailBillingState();
}

class _DetailBillingState extends State<DetailBilling> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: GlobalTopBar(
          onMenuPressed: widget.onMenuPressed,
          title: 'Detail Billing',
          isExpanded: widget.isExpanded),
      body: Center(
        child: Text('ini detail billing'),
      ),
    );
  }
}
