import 'dart:ui';

import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

void paintLabelImage(LabelImageObject image, Canvas canvas, Size size) {
  Paint paint = Paint();
  final widthFactor = image.width / image.image.width;
  final heightFactor = image.height / image.image.height;

  canvas.scale(widthFactor, heightFactor);
  canvas.drawImage(
      image.image,
      Offset(
          image.position.left / widthFactor, image.position.top / heightFactor),
      paint);
  canvas.scale(1 / widthFactor, 1 / heightFactor);
}
