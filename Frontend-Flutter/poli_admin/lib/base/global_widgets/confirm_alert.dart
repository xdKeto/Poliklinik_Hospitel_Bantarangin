import 'package:flutter/material.dart';
import 'package:poli_admin/base/global_widgets/the_button.dart';
import 'package:poli_admin/base/utils/app_styles.dart';

class ConfirmAlert extends StatelessWidget {
  final IconData icon;
  final String boldText;
  final String italicText;
  final String yesText;
  final VoidCallback? yesFunc;
  const ConfirmAlert(
      {super.key,
      required this.icon,
      required this.boldText,
      this.italicText = '',
      required this.yesText,
      this.yesFunc});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
        child: Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 500,
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppStyles.accentColor,
              size: 80,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              boldText,
              style:
                  AppStyles.headingText.copyWith(fontWeight: FontWeight.bold),
            ),
            italicText == ''
                ? SizedBox(
                    height: 0,
                  )
                : SizedBox(
                    height: 6,
                  ),
            italicText == ''
                ? SizedBox(
                    height: 0,
                  )
                : Text(
                    italicText,
                    style: AppStyles.contentText
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TheButton(
                  text: 'Tidak',
                  color: AppStyles.greyBtnColor,
                  textColor: AppStyles.greyBtnColor,
                  border: true,
                  onTapFunc: () {
                    Navigator.pop(context);
                  },
                  vertPadding: 8.5,
                  horiPadding: 32.5,
                ),
                SizedBox(
                  width: 16,
                ),
                TheButton(
                  text: 'Ya, $yesText',
                  color: AppStyles.accentColor,
                  textColor: AppStyles.accentColor,
                  border: true,
                  onTapFunc: yesFunc,
                  vertPadding: 8.5,
                  horiPadding: 32.5,
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    ));
  }
}
