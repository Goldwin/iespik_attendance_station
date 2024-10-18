import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/label/label_text_object.dart';

void paintText(
    LabelTextObject text, Map<String, dynamic> data, Canvas canvas, Size size) {
  final width = text.width;
  final height = text.height;
  final left = text.position.left;
  final top = text.position.top;

  TextPainter tp = TextPainter(
    text: TextSpan(
      text: data[text.name] ?? text.name,
      style: TextStyle(
        color: Color(int.parse(text.color?.replaceAll('#', 'FF') ?? 'FF000000',
            radix: 16)),
        fontSize: text.size.toDouble(),
        fontFamily: "Lato",
        overflow: TextOverflow.visible,
      ),
    ),
    maxLines: 1,
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  tp.layout(
    minWidth: width,
    maxWidth: double.infinity,
  );

  if (text.background != null) {
    Paint bgPaint = Paint();
    bgPaint.color = Color(int.parse(
        text.background?.replaceAll('#', 'FF') ?? 'FFFFFFFF',
        radix: 16));

    canvas.drawRect(Rect.fromLTWH(left, top, width, height), bgPaint);
  }

  final widthFactor = width / tp.width;
  final transformedHeight = tp.height * widthFactor;
  canvas.scale(widthFactor);
  tp.paint(
    canvas,
    Offset(left / widthFactor,
        (top + height / 2 - transformedHeight / 2) / widthFactor),
  );
  canvas.scale(1 / widthFactor);
  tp.dispose();
}
