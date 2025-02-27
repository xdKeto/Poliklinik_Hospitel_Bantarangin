import 'package:flutter/material.dart';
import 'package:poli_suster/base/class/event.dart';
import 'package:poli_suster/screens/riwayat/data_field.dart';

class DataRiwayat extends StatelessWidget {
  final HealthRecord data;
  const DataRiwayat({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // print(data.catatan);
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataField(
                  title: "Tensi Darah", data: data.tensiDarah, type: "mmHg"),
              DataField(
                  title: "Berat Badan",
                  data: data.beratBadan.toString(),
                  type: "kg"),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataField(
                  title: "Tinggi Badan",
                  data: data.tinggiBadan.toString(),
                  type: "cm"),
              DataField(
                  title: "Suhu Tubuh",
                  data: data.suhuTubuh.toString(),
                  type: "°C"),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataField(
                  title: "Gula Darah",
                  data: data.gulaDarah.toString(),
                  type: "mg/dL"),
              DataField(
                  title: "Detak / Nadi",
                  data: data.detakNadi.toString(),
                  type: "hbpm"),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataField(
                  title: "Resp. Rate",
                  data: data.respRate.toString(),
                  type: "menit"),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DataField(
                title: "Catatan Tambahan",
                data: data.catatan,
                type: "",
                isLong: true,
              )
            ],
          )
        ],
      ),
    );
  }
}
