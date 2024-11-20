import 'dart:ui';

import 'package:iespik_attendance_station/app/attendance/utilities/label/label_painter.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

Picture generateLabel(Label label, ChurchEventAttendance attendance) {
  final recorder = PictureRecorder();
  final canvas = Canvas(
      recorder, Rect.fromLTWH(0, 0, label.paperSize[0], label.paperSize[1]));
  final painter = LabelPainter(label, {
    "currentDate": attendance.checkinTime.toString().substring(0, 10),
    "securityCode": attendance.securityCode,
    "numbersWithName":
        '#${attendance.securityNumber}: ${attendance.checkinBy.firstName}',
    "firstName": attendance.attendee.firstName,
    "lastName": attendance.attendee.lastName,
    "kind": attendance.attendanceType,
    "currentDateWithActivity":
        '${attendance.checkinTime.toString().substring(0, 10)} - ${attendance.activity.name}',
    "checkedInBy":
        '${attendance.checkinBy.firstName} ${attendance.checkinBy.lastName}'
  });
  painter.paint(canvas, Size(label.paperSize[0], label.paperSize[1]));
  return recorder.endRecording();
}
