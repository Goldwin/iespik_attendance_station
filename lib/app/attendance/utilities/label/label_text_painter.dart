import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/label/label_text_object.dart';

void paintText(
    LabelTextObject text, Map<String, dynamic> data, Canvas canvas, Size size) {
  final width = text.width;
  final height = text.height;
  final left = text.position.left;
  final top = text.position.top;

  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  for (String style in text.styles ?? []) {
    if (style == 'bold') {
      isBold = true;
    } else if (style == 'italic') {
      isItalic = true;
    } else if (style == 'underline') {
      isUnderline = true;
    }
  }

  TextAlign textAlign = TextAlign.values.singleWhere(
    (value) => value.name == text.align,
    orElse: () => TextAlign.center,
  );

  TextPainter tp = TextPainter(
    text: TextSpan(
      text: '${data[text.name] ?? text.name}',
      style: TextStyle(
        color: Color(int.parse(text.color?.replaceAll('#', 'FF') ?? 'FF000000',
            radix: 16)),
        fontSize: text.size.toDouble(),
        fontWeight: isBold ? FontWeight.bold : null,
        fontStyle: isItalic ? FontStyle.italic : null,
        decoration: isUnderline ? TextDecoration.underline : null,
        fontVariations: const <FontVariation>[],
        fontFamily: text.font ?? "Lato",
        overflow: TextOverflow.visible,
        textBaseline: TextBaseline.alphabetic,
      ),
    ),
    maxLines: 1,
    textAlign: textAlign,
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
    Offset((left + 2) / widthFactor,
        (top + height / 2 - transformedHeight / 2) / widthFactor),
  );
  canvas.scale(1 / widthFactor);
  tp.dispose();
}
