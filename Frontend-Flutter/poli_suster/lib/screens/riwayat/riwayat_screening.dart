import 'package:flutter/material.dart';
import 'package:poli_suster/base/class/event.dart';
import 'package:poli_suster/base/dummy/data.dart';
import 'package:poli_suster/screens/riwayat/container_data.dart';
import 'package:poli_suster/screens/riwayat/detail_riwayat.dart';

class RiwayatScreening extends StatefulWidget {
  const RiwayatScreening({super.key});

  @override
  State<RiwayatScreening> createState() => _RiwayatScreeningState();
}

class _RiwayatScreeningState extends State<RiwayatScreening> {
  List<HealthRecord> listScreening = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < listRiwayat.length; i++) {
      listScreening.add(HealthRecord.fromJson(listRiwayat[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  // flex: 25,
                  child: Container(
                // padding: EdgeInsets.all(24),
                margin: EdgeInsets.only(right: 4),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 5 / 6),
                    itemCount: listRiwayat.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) =>
                                    DetailRiwayat(data: listScreening[index]));
                          },
                          child: ContainerData(data: listScreening[index]));
                    }),
              )),
            ],
          )
        ],
      ),
    );
  }
}
