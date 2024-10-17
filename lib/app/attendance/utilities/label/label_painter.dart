import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/label.dart';

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
    canvas.drawCircle(Offset(10, 10), 10, Paint()..color = Colors.red);

    TextPainter tp = TextPainter(
      text: TextSpan(
        text: "henlo, this is the very long text. it won't fit",
        style: TextStyle(
          color: Color(int.parse("FF000000", radix: 16)),
          //color: Colors.black,
          fontSize: 30,
          fontFamily: "Lato",
          overflow: TextOverflow.visible,
        ),
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    final expectedWidth =
        _label.paperSize[0] - _label.margin[0] - _label.margin[2];
    final scaleFactor = expectedWidth / tp.width;

    canvas.scale(scaleFactor, scaleFactor);
    tp.paint(
      canvas,
      Offset(0, 0),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
