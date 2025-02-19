import 'package:flutter/material.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class RiwayatScreening extends StatefulWidget {
  const RiwayatScreening({super.key});

  @override
  State<RiwayatScreening> createState() => _RiwayatScreeningState();
}

class _RiwayatScreeningState extends State<RiwayatScreening> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Tanggal',
            style: AppStyles.contentText.copyWith(
                fontWeight: FontWeight.w600, color: AppStyles.primaryColor),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 4),
                    color: Colors.red,
                    // child: ,
                  )),
              Flexible(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // height: 50,
                    margin: EdgeInsets.only(left: 4),
                    color: Colors.blue,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
