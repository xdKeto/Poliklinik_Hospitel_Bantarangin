import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_suster/base/class/event.dart';
import 'package:poli_suster/base/global_widgets/bold_n_reg_text.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class ContainerData extends StatelessWidget {
  final HealthRecord data;
  const ContainerData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppStyles.whiteBox,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('dd MMMM yyyy', "id_ID")
                    .format(DateTime.parse(data.tanggal))
                    .toString(),
                style: AppStyles.subheadingText.copyWith(
                    color: AppStyles.primaryColor, fontWeight: FontWeight.bold),
              ),
              Icon(
                FluentIcons.arrow_expand_16_regular,
                color: AppStyles.primaryColor,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          BoldNRegText(
              label: "Catatan",
              data:
                  "${data.catatan} Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur lacus quam, viverra eget lorem nec, facilisis. ",
              type: ""),
        ],
      ),
    );
  }
}
