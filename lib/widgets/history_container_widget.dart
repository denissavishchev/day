import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../models/history_model.dart';

class HistoryContainerWidget extends StatelessWidget {
  const HistoryContainerWidget({
    super.key,
    required this.history,
    required this.index,
  });

  final List<HistoryModel> history;
  final int index;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.30,
          margin: const EdgeInsets.fromLTRB(12, 0, 0, 8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                kGrey,
                kBlue,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                  color: kBlack.withOpacity(0.6),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: const Offset(0, 1)
              )
            ],
          ),
          child: Center(child: Text('Date ${DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].time))}')),
        ),
        Positioned(
          left: size.width * 0.62,
          child: Container(
            height: size.height * 0.05,
            width: size.width * (((double.parse(history[index].duration.substring(0, 2)))) -10) / 20,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  kGrey,
                  kBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                    color: kBlack.withOpacity(0.6),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: const Offset(8, 1)
                )
              ],
            ),
            child: Text('Duration ${history[index].duration}'),
          ),
        ),
        Positioned(
          left: size.width * 0.32,
          child: Container(
            height: size.height * 0.05,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              color: kGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    color: history[index].status1 == 'true' ? kRed : kGrey,
                    boxShadow: [
                      BoxShadow(
                        color: history[index].status1 == 'true' ? kRed.withOpacity(0.9) : kGrey.withOpacity(0.5),
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ]
                  ),
                ),
                VerticalDivider(color: kBlue.withOpacity(0.5), width: 0.7,),
                Container(
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                      color: history[index].status2 == 'true' ? kRed : kGrey,
                      boxShadow: [
                        BoxShadow(
                          color: history[index].status2 == 'true' ? kRed.withOpacity(0.9) : kGrey.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                ),
                VerticalDivider(color: kBlue.withOpacity(0.5), width: 0.7,),
                Container(
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                      color: history[index].status3 == 'true' ? kRed : kGrey,
                      boxShadow: [
                        BoxShadow(
                          color: history[index].status3 == 'true' ? kRed.withOpacity(0.9) : kGrey.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}