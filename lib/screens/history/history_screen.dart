import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lipread/components/empty_data.dart';
import 'package:lipread/components/static_widget.dart';
import 'package:lipread/models/history/history_day_model.dart';
import 'package:lipread/models/history/history_learning_static_model.dart';
import 'package:lipread/models/history/history_model.dart';
import 'package:lipread/screens/learning_static/learning_static_screen.dart';
import 'package:lipread/services/history_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';
import 'package:lipread/utilities/functions.dart';
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

  final Future<HistoryLearningStaticModel?> _learningStatics =
      HistoryService.getLearningStatic();

  late Future<List<HistorysOfDayModel>> _monthlyHistory;

  String _getFormattedSelectedDay(DateTime day) {
    return '${day.year}년 ${day.month}월 ${day.day}일';
  }

  HistorysOfDayModel _getHistoriesOnSelectedDay(
      List<HistorysOfDayModel> histories, int day) {
    return histories.firstWhere((history) => history.dateTime.day == day,
        orElse: () => HistorysOfDayModel(
            dateTime:
                DateTime(DateTime.now().year, DateTime.now().month, day)));
  }

  @override
  void initState() {
    super.initState();
    _monthlyHistory = HistoryService.getMonthlyLearningHistory(
        year: _selectedDay.year, month: _selectedDay.month);
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
              FutureBuilder(
                  future: _learningStatics,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        debugPrint('${snapshot.error}');
                        return throw Error();
                      } else {
                        HistoryLearningStaticModel learningStatic =
                            snapshot.data!;
                        return Row(
                          children: [
                            Expanded(
                              child: StaticWidget(
                                title: '총 연습한 문장',
                                value: learningStatic.totalLearningSentenceCount
                                    .toString(),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: StaticWidget(
                                title: '총 학습한 시간',
                                value: formatTotalLearningTimeWith(
                                    learningStatic
                                        .totalLearningTimeInMilliseconds),
                              ),
                            ),
                          ],
                        );
                      }
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.grayScale.g200,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Container(
                            height: 120,
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.grayScale.g200,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
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
              FutureBuilder(
                future: _monthlyHistory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      debugPrint('에러: ${snapshot.error}');
                      return throw Error();
                    } else {
                      List<HistorysOfDayModel> historysOfDayList =
                          snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TableCalendar(
                            availableGestures: AvailableGestures.none,
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
                              setState(() {
                                _focusedDay = focusedDay;
                                _selectedDay = focusedDay;
                              });
                              debugPrint(_focusedDay.month.toString());
                              debugPrint(_focusedDay.day.toString());

                              _monthlyHistory =
                                  HistoryService.getMonthlyLearningHistory(
                                      year: _selectedDay.year,
                                      month: _selectedDay.month);
                            },
                            eventLoader: (date) {
                              HistorysOfDayModel historysOfDay =
                                  _getHistoriesOnSelectedDay(
                                      historysOfDayList, date.day);
                              return historysOfDay.historysOfDay;
                            },
                            calendarBuilders: CalendarBuilders(
                              markerBuilder:
                                  (context, day, List<HistoryModel> events) {
                                if (events.isNotEmpty) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: events.length,
                                    itemBuilder: (context, index) {
                                      // HistorysOfDayModel historyDay = iconEvents[index];
                                      return SizedBox(
                                        width: 6,
                                        height: 6,
                                        child: Text(
                                          events[index].emoji,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 1,
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
                                fontVariations: const [
                                  FontVariation('wght', 600)
                                ],
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
                                fontVariations: const [
                                  FontVariation('wght', 500)
                                ],
                                color: AppColor.grayScale.g700,
                                height: 1,
                              ),
                              weekendStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: FontType.pretendard.name,
                                fontVariations: const [
                                  FontVariation('wght', 500)
                                ],
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
                                fontVariations: const [
                                  FontVariation('wght', 700)
                                ],
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
                                fontVariations: const [
                                  FontVariation('wght', 800)
                                ],
                                color: AppColor.primaryLightColor,
                                height: 1,
                              ),
                              disabledTextStyle: TextStyle(
                                fontSize: 14,
                                fontFamily: FontType.pretendard.name,
                                fontVariations: const [
                                  FontVariation('wght', 600)
                                ],
                                color: AppColor.grayScale.g300,
                                height: 1,
                              ),
                              outsideDaysVisible: false,
                              canMarkersOverflow: false,
                              markersAutoAligned: true,
                              markersAlignment: Alignment.bottomLeft,
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
                          _getHistoriesOnSelectedDay(
                                      historysOfDayList, _selectedDay.day)
                                  .historysOfDay
                                  .isEmpty
                              ? const EmptyData(text: '학습 기록이 없습니다')
                              : HistoryCard(
                                  histories: _getHistoriesOnSelectedDay(
                                          historysOfDayList, _selectedDay.day)
                                      .historysOfDay,
                                ),
                        ],
                      );
                    }
                  }
                  return Column(
                    children: [
                      Container(
                        height: 360,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grayScale.g200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grayScale.g200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 200,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.grayScale.g200,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
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

class HistoryCard extends StatelessWidget {
  final List<HistoryModel> histories;

  const HistoryCard({
    super.key,
    required this.histories,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LearningStaticScreen(histories[index].id),
              ),
            ),
            child: Container(
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
              child: Row(
                children: [
                  Text(
                    histories[index].emoji,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    histories[index].title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 12,
          );
        },
        itemCount: histories.length);
  }
}
