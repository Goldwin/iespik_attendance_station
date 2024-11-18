import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/domains/attendance/entities/events/church_event_schedule.dart';

typedef OnTimeout = void Function();

class CheckinCompletedPage extends StatelessWidget {
  final int timeoutSeconds;
  final OnTimeout onTimeout;
  final ChurchEventSchedule churchEventSchedule;

  const CheckinCompletedPage(
      {required this.churchEventSchedule,
      required this.onTimeout,
      this.timeoutSeconds = 3,
      super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: timeoutSeconds), onTimeout);
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 100),
      child: Container(
        color: Theme.of(context).colorScheme.surfaceBright,
        height: 100,
        child: Center(
          child: Text(
              'Welcome to ${churchEventSchedule.name} event. Enjoy the service :)'),
        ),
      ),
    );
  }
}
