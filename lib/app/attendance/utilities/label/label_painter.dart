import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/utilities/label/label_image_painter.dart';
import 'package:iespik_attendance_station/core/domains/attendance/index.dart';

import 'label_line_painter.dart';
import 'label_text_painter.dart';

class LabelPainter extends CustomPainter {
  final Label _label;
  final Map<String, dynamic> data;

  LabelPainter(this._label, this.data);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.grey);
    canvas.drawRect(
        Rect.fromLTRB(
            _label.margin[0],
            _label.margin[1],
            _label.paperSize[0] - _label.margin[2],
            _label.paperSize[1] - _label.margin[3]),
        Paint()..color = Colors.white);
    canvas.translate(_label.margin[0], _label.margin[1]);
    int count = 0;
    for (LabelObject object in _label.objects) {
      ++count;
      if (object is LabelTextObject) {
        paintText(object, data, canvas, size);
      } else if (object is LabelLineObject) {
        paintLine(object, canvas, size);
      } else if (object is LabelImageObject) {
        paintLabelImage(object, canvas, size);
      }
    }
    debugPrint("count: $count");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
