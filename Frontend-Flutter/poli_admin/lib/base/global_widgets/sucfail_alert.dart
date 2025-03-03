import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class SucfailAlert extends StatefulWidget {
  final bool isSuccess;
  final String boldText;
  final String italicText;
  const SucfailAlert(
      {super.key,
      required this.isSuccess,
      required this.boldText,
      required this.italicText});

  @override
  State<SucfailAlert> createState() => _SucfailAlertState();
}

class _SucfailAlertState extends State<SucfailAlert>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimate;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    scaleAnimate =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
        child: Dialog(
      backgroundColor: Colors.transparent,
      child: ScaleTransition(
        scale: scaleAnimate,
        child: Container(
          width: 500,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isSuccess
                    ? FluentIcons.checkmark_circle_12_filled
                    : FluentIcons.error_circle_12_filled,
                color: widget.isSuccess
                    ? AppStyles.greenColor
                    : AppStyles.redColor,
                size: 80,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                widget.boldText,
                style:
                    AppStyles.headingText.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                widget.italicText,
                style:
                    AppStyles.contentText.copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 12,
              ),
              widget.isSuccess
                  ? SizedBox(height: 0)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: TheButton(
                            text: 'Tutup',
                            color: widget.isSuccess
                                ? AppStyles.greenColor
                                : AppStyles.redColor,
                            textColor: widget.isSuccess
                                ? AppStyles.greenColor
                                : AppStyles.redColor,
                            border: true,
                            vertPadding: 8.5,
                            horiPadding: 32.5,
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    ));
  }
}
