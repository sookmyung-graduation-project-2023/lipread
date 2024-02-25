import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lipread/models/history_day_model.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  List<HistoryDayModel> list = [
    HistoryDayModel(
      id: 'id',
      emoji: '☕',
      title: 'title',
    ),
    HistoryDayModel(
      id: 'id',
      emoji: '☕',
      title: 'title',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('학습 기록'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "학습 전체 통계",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Expanded(
                    child: StaticWidget(
                      title: '총 연습한 문장',
                      value: '24',
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: StaticWidget(
                      title: '총 연습한 문장',
                      value: '24',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "전체 학습 기록",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 12,
              ),
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.now(),
                locale: 'ko_KR',
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      List iconEvents = events;
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          Map key = iconEvents[index];
                          if (key['iconIndex'] == 1) {
                            return Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: const Icon(
                                size: 20,
                                Icons.pets_outlined,
                                color: Colors.purpleAccent,
                              ),
                            );
                          } else if (key['iconIndex'] == 2) {
                            return Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: const Icon(
                                size: 20,
                                Icons.rice_bowl_outlined,
                                color: Colors.teal,
                              ),
                            );
                          } else if (key['iconIndex'] == 3) {
                            return Container(
                              margin: const EdgeInsets.only(top: 40),
                              child: const Icon(
                                size: 20,
                                Icons.water_drop_outlined,
                                color: Colors.redAccent,
                              ),
                            );
                          }
                          return null;
                        },
                      );
                    }
                    return null;
                  },
                ),
                rowHeight: 56,
                daysOfWeekHeight: 32,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  titleTextFormatter: (date, locale) =>
                      DateFormat.yMMM(locale).format(date),
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 16,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 600)],
                    color: AppColor.grayScale.g800,
                    height: 1,
                  ),
                  headerPadding: const EdgeInsets.only(bottom: 16),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 24.0,
                    color: AppColor.grayScale.g700,
                  ),
                  leftChevronPadding: const EdgeInsets.all(4),
                  rightChevronPadding: const EdgeInsets.all(4),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24.0,
                    color: AppColor.grayScale.g700,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 500)],
                    color: AppColor.grayScale.g700,
                    height: 1,
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 500)],
                    color: AppColor.grayScale.g700,
                    height: 1,
                  ),
                ),
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  todayDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 700)],
                    color: AppColor.primaryColor,
                    height: 1,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 800)],
                    color: AppColor.primaryLightColor,
                    height: 1,
                  ),
                  canMarkersOverflow: false,
                  markersAutoAligned: true,
                  markerSize: 10.0,
                  markerSizeScale: 10.0,
                  markersAnchor: 0.7,
                  markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),
                  markersAlignment: Alignment.bottomCenter,
                  markersMaxCount: 4,
                  markersOffset: const PositionedOffset(),
                  markerDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StaticWidget extends StatelessWidget {
  final String title;
  final String value;

  const StaticWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        border: Border.all(
          width: 1,
          color: AppColor.grayScale.g200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontFamily: FontType.pretendard.name,
              fontVariations: const [FontVariation('wght', 700)],
              color: AppColor.primaryColor,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
