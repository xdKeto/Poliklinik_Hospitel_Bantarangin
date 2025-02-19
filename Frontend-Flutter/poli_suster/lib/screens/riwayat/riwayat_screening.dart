import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:poli_suster/base/utils/app_styles.dart';

class RiwayatScreening extends StatefulWidget {
  const RiwayatScreening({super.key});

  @override
  State<RiwayatScreening> createState() => _RiwayatScreeningState();
}

class _RiwayatScreeningState extends State<RiwayatScreening> {
  DateTime _selectedDate = DateTime.now();

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
                    child: CalendarCarousel(
                      weekendTextStyle: TextStyle(
                        color: Colors.red,
                      ),
                      selectedDateTime: _selectedDate,
                      thisMonthDayBorderColor: AppStyles.greyColor,
                      showIconBehindDayText: true,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDateShowIcon: true,
                      selectedDayTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                      todayTextStyle: TextStyle(
                        color: Colors.black,
                      ),
                      todayButtonColor: Colors.transparent,
                      headerTextStyle: AppStyles.tambahanText.copyWith(
                          color: AppStyles.textColor,
                          fontWeight: FontWeight.w600),
                      iconColor: Colors.black,
                      weekdayTextStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      selectedDayButtonColor:
                          AppStyles.secondaryColor.withValues(alpha: 0.5),
                    ),
                  )),
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
                              '19 Feburari 2025',
                              style: AppStyles.sidebarText.copyWith(
                                  color: AppStyles.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              Icon(
                                FluentIcons.document_dismiss_16_regular,
                                color: AppStyles.greyColor,
                                size: 86,
                              ),
                              Text(
                                'Data screening\ntidak ditemukan',
                                style: AppStyles.titleText.copyWith(
                                  color: AppStyles.greyColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
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
