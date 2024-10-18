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

    final width = 200.0;
    final height = 60.0;
    final left = 0.0;
    final top = 0.0;

    TextPainter tp = TextPainter(
      text: TextSpan(
        text: "henlo",
        style: TextStyle(
          color: Color(int.parse("FFFFFFFF", radix: 16)),
          //color: Colors.black,
          fontSize: 30,
          fontFamily: "Lato",
          overflow: TextOverflow.visible,
        ),
      ),
      maxLines: 1,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      textWidthBasis: TextWidthBasis.parent,
    );
    tp.layout(
      minWidth: width,
      maxWidth: double.infinity,
    );

    canvas.drawRect(
        Rect.fromLTWH(left, top, width, height), Paint()..color = Colors.black);
    final widthFactor = width / tp.width;
    final transformedHeight = tp.height * widthFactor;
    canvas.scale(widthFactor);
    tp.paint(
      canvas,
      Offset(0, (height / 2 - transformedHeight / 2) / widthFactor),
    );
    canvas.scale(1 / widthFactor);
    tp.dispose();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
