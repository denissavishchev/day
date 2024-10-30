import 'package:day/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/habit_history_model.dart';

class HabitHistoryContainerWidget extends StatelessWidget {
  const HabitHistoryContainerWidget({
    super.key,
    required this.history,
    required this.index,
    required this.box,
  });

  final List<HabitHistoryModel> history;
  final int index;
  final Box<HabitHistoryModel> box;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
        builder: (context, data, _){
          return GestureDetector(
            onLongPress: () => data.deleteHistoryHabit(box, index),
            child: Container(
                margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      kBlue,
                      kGrey,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(
                        color: kBlack.withOpacity(0.6),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 1)
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(history[index].name,
                          style: const TextStyle(color: kRed, fontWeight: FontWeight.bold),),
                        Row(
                          children: [
                            Text('Total days: ', style: TextStyle(color: kRed.withOpacity(0.6), fontWeight: FontWeight.bold),),
                            Text(history[index].totalDays,
                              style: const TextStyle(color: kRed, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text('Start: ',
                                style: TextStyle(color: kRed.withOpacity(0.6), fontWeight: FontWeight.bold),),
                              Text(DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].startTime)),
                                style: const TextStyle(color: kRed,fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(
                            children: [
                              Text('End: ',
                                style: TextStyle(color: kRed.withOpacity(0.6), fontWeight: FontWeight.bold),),
                              Text(DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].endTime)),
                                style: const TextStyle(color: kRed,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: kGreen,
                                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                                    border: Border.all(width: 1, color: kBlack)
                                ),
                              ),
                              const Text('- ', style: kTextStyle,),
                              Text(history[index].goodDays, style: kTextStyle,),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: kNavy.withOpacity(0.2),
                                    borderRadius: const BorderRadius.all(Radius.circular(3)),
                                    border: Border.all(width: 1, color: kBlack)
                                ),
                              ),
                              const Text('- ', style: kTextStyle,),
                              Text(history[index].badDays, style: kTextStyle,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
          );
        }
    );
  }
}


