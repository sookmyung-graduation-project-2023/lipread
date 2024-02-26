import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lipread/components/static_widget.dart';
import 'package:lipread/models/history/history_day_model.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime _focusedDay = DateTime.now();
/*
  List<Event> _getHistoryForDay(DateTime day) {
  return events[day] ?? [];
}*/

  String _getFormattedSelectedDay(DateTime day) {
    return '${day.year}년 ${day.month}월 ${day.day}일';
  }

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
                      title: '총 학습한 시간',
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
                eventLoader: (day) {
                  if (day.day % 2 == 0) {
                    return [];
                  } else {
                    return [];
                  }
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      List iconEvents = events;
                      return ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          // HistorysOfDayModel historyDay = iconEvents[index];
                          return const Text(
                            '3',
                            style: TextStyle(fontSize: 12),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 2,
                          );
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
                  disabledTextStyle: TextStyle(
                    fontSize: 14,
                    fontFamily: FontType.pretendard.name,
                    fontVariations: const [FontVariation('wght', 600)],
                    color: AppColor.grayScale.g300,
                    height: 1,
                  ),
                  outsideDaysVisible: false,
                  canMarkersOverflow: false,
                  markersAutoAligned: true,
                  markersAlignment: Alignment.bottomCenter,
                  markersMaxCount: 4,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "${_getFormattedSelectedDay(_selectedDay)} 학습 기록",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('향수 구매하기'),
                          Text('24:00:00'),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: 10),
              const SizedBox(
                height: 44,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
