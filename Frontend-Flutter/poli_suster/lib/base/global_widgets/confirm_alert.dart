import 'package:flutter/material.dart';
import 'package:poli_suster/base/global_widgets/the_button.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class ConfirmAlert extends StatelessWidget {
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
              color: color ?? AppStyles.accentColor,
              size: 80,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              boldText,
              style:
                  AppStyles.headingText.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
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
                  onTap: yesFunc,
                  child: TheButton(
                    text: 'Ya, $yesText',
                    color: color ?? AppStyles.accentColor,
                    textColor: color ?? AppStyles.accentColor,
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
    ));
  }
}
