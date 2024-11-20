import 'dart:ui';

import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

void paintLine(LabelLineObject line, Canvas canvas, Size size) {
  Paint paint = Paint();
  paint.color = Color(int.parse(
      line.strokeColor?.replaceAll('#', 'FF') ?? 'FF000000',
      radix: 16));
  paint.strokeWidth = line.size?.toDouble() ?? 1.0;
  canvas.drawLine(Offset(line.startPoint[0], line.startPoint[1]),
      Offset(line.endPoint[0], line.endPoint[1]), paint);
}
