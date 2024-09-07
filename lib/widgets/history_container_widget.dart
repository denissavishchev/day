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
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.30,
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
          Text('Date ${DateFormat('dd.MM.yyyy').format(DateTime.parse(history[index].time))}'),
          Text('Duration ${history[index].duration}'),
          const SizedBox(width: 12,),
          DotWidget(status: history[index].status1,),
          DotWidget(status: history[index].status2,),
          DotWidget(status: history[index].status3,),
        ],
      )
    );
  }
}

class DotWidget extends StatelessWidget {
  const DotWidget({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.05,
      height: size.width * 0.05,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                status == 'true' ? kGrey : kWhite.withOpacity(0.4),
                status == 'true' ? kRed : kGrey,
              ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: status == 'true' ? kBlack.withOpacity(0.4) : kWhite.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.5),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ]
      ),
    );
  }
}

