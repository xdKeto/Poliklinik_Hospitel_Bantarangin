import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class ConfirmAlert extends StatefulWidget {
  final IconData icon;
  final String boldText;
  final String italicText;
  final String yesText;
  final VoidCallback? yesFunc;
  final Color? color;
  const ConfirmAlert(
      {super.key,
      required this.icon,
      required this.boldText,
      this.italicText = '',
      required this.yesText,
      this.yesFunc,
      this.color});

  @override
  State<ConfirmAlert> createState() => _ConfirmAlertState();
}

class _ConfirmAlertState extends State<ConfirmAlert>
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
                widget.icon,
                color: widget.color ?? AppStyles.accentColor,
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
              widget.italicText == ''
                  ? SizedBox(
                      height: 0,
                    )
                  : SizedBox(
                      height: 6,
                    ),
              widget.italicText == ''
                  ? SizedBox(
                      height: 0,
                    )
                  : Text(
                      widget.italicText,
                      style: AppStyles.contentText
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: TheButton(
                      text: 'Tidak',
                      color: AppStyles.greyBtnColor,
                      textColor: AppStyles.greyBtnColor,
                      border: true,
                      vertPadding: 8.5,
                      horiPadding: 32.5,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: widget.yesFunc,
                    child: TheButton(
                      text: 'Ya, ${widget.yesText}',
                      color: widget.color ?? AppStyles.accentColor,
                      textColor: widget.color ?? AppStyles.accentColor,
                      border: true,
                      vertPadding: 8.5,
                      horiPadding: 32.5,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
