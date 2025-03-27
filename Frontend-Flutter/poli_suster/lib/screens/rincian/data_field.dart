import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class DataField extends StatefulWidget {
  final String title;
  final String data;
  final bool isLong;
  const DataField(
      {super.key,
      required this.title,
      required this.data,
      this.isLong = false});

  @override
  State<DataField> createState() => _DataFieldState();
}

class _DataFieldState extends State<DataField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.data);
  }

  @override
  void didUpdateWidget(covariant DataField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      _controller.text = widget.data;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: AppStyles.contentText.copyWith(
              color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 8,
        ),
        Row(children: [
          Expanded(
            child: TextFormField(
              readOnly: true,
              controller: _controller,
              maxLines: 2,
              cursorColor: Colors.black,
              decoration: AppStyles.formBox.copyWith(),
              onChanged: (value) {},
            ),
          ),
        ])
      ],
    );
  }
}
