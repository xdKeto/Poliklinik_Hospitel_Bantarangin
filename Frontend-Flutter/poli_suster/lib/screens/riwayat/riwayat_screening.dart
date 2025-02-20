import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poli_suster/base/class/event.dart';
import 'package:poli_suster/base/dummy/data.dart';
import 'package:poli_suster/base/utils/app_styles.dart';
import 'package:poli_suster/screens/riwayat/data_riwayat.dart';
import 'package:table_calendar/table_calendar.dart';

class RiwayatScreening extends StatefulWidget {
  const RiwayatScreening({super.key});

  @override
  State<RiwayatScreening> createState() => _RiwayatScreeningState();
}

class _RiwayatScreeningState extends State<RiwayatScreening> {
  DateTime _selectedDate = DateTime.now();

  Map<DateTime, List<HealthRecord>> listScreening = {};

  late final ValueNotifier<List<HealthRecord>> _selectedRiwayat;

  void _onDayPress(DateTime day, DateTime focused) {
    setState(() {
      _selectedDate = day;
      List<HealthRecord> riwayat = _getRiwayat(_selectedDate);
      _selectedRiwayat.value = riwayat;
    });

    // print(_selectedRiwayat.value[0].catatan);
  }

  List<HealthRecord> _getRiwayat(DateTime date) {
    return listRiwayat
        .where((record) {
          DateTime recordDate = DateTime.parse(record['tanggal']);
          return recordDate.year == date.year &&
              recordDate.month == date.month &&
              recordDate.day == date.day;
        })
        .map((record) => HealthRecord.fromJson(record))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    for (var entry in listRiwayat) {
      DateTime date = DateTime.parse(entry['tanggal']);
      HealthRecord event = HealthRecord.fromJson(entry);

      if (listScreening.containsKey(date)) {
        listScreening[date]!.add(event);
      } else {
        listScreening[date] = [event];
      }
    }

    _selectedRiwayat = ValueNotifier(_getRiwayat(_selectedDate));

    print(listScreening);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                  flex: 4,
                  child: Container(
                      height: screenHeight,
                      width: screenWidth,
                      margin: EdgeInsets.only(right: 4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppStyles.greyColor, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      child: TableCalendar(
                          locale: "id_ID",
                          focusedDay: _selectedDate,
                          currentDay: _selectedDate,
                          onDaySelected: _onDayPress,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, _selectedDate),
                          eventLoader: _getRiwayat,
                          headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              titleTextStyle: AppStyles.sidebarText.copyWith(
                                  color: AppStyles.primaryColor,
                                  fontWeight: FontWeight.bold)),
                          calendarStyle: CalendarStyle(
                            selectedTextStyle: TextStyle(color: Colors.black),
                            selectedDecoration: BoxDecoration(
                                color: AppStyles.secondaryColor
                                    .withValues(alpha: 0.5),
                                shape: BoxShape.circle),
                            markerDecoration: BoxDecoration(
                                color: AppStyles.accentColor,
                                shape: BoxShape.circle),
                            holidayTextStyle:
                                TextStyle(color: AppStyles.redColor),
                            weekendTextStyle:
                                TextStyle(color: AppStyles.redColor),
                          ),
                          firstDay: DateTime.utc(2005, 10, 10),
                          lastDay: DateTime(2050, 10, 10)))),
              Flexible(
                  flex: 5,
                  child: Container(
                    height: screenHeight,
                    width: screenWidth,
                    margin: EdgeInsets.only(left: 4),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppStyles.greyColor, width: 2),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy', "id_ID")
                                  .format(_selectedDate),
                              style: AppStyles.sidebarText.copyWith(
                                  color: AppStyles.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ValueListenableBuilder<List<HealthRecord>>(
                            valueListenable: _selectedRiwayat,
                            builder: (context, value, _) {
                              if (value.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                          FluentIcons
                                              .document_dismiss_16_regular,
                                          color: AppStyles.greyColor,
                                          size: 86),
                                      Text(
                                        'Data screening\ntidak ditemukan',
                                        style: AppStyles.titleText.copyWith(
                                          color: AppStyles.greyColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return DataRiwayat(data: value[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
