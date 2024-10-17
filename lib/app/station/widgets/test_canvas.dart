import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/domains/attendance/entities/label.dart';
import 'package:iespik_attendance_station/infra/printer/printer_manager.dart';

class TestCanvas extends StatefulWidget {
  const TestCanvas({super.key});

  @override
  State<TestCanvas> createState() => _TestCanvasState();
}

class _TestCanvasState extends State<TestCanvas> {
  @override
  Widget build(BuildContext context) {
    String json =
        '{"id":"1", "name":"Test Run","paperSize":[288.0,166.5],"margin":[0.0,0.0,0.0,0.0],"objects":[{"type":"text","name":"current_date","color":"#000000","background":null,"font":"Lato","styles":[],"overflow":"shrinkToFit","align":"center","valign":"center","vertical":false,"at":[21.95,9.75],"width":248.2,"height":26.6,"size":24},{"type":"text","name":"security_code","color":"#ffffff","background":"#000000","font":"Lato","styles":["bold"],"overflow":"truncate","align":"center","valign":"center","vertical":false,"at":[17.3,52.15],"width":253.2,"height":62.65,"size":36},{"at":[34.56,124.875],"width":218.88,"height":31.21875,"type":"text","align":"center","color":"#000000","size":24,"valign":"bottom","vertical":false,"styles":["bold"],"padding":2,"overflow":"shrinkToFitAndWrap","rotate":0,"name":"numbers_with_names"}],"orientation":"landscape"}';

    Map<String, dynamic> data = {
      "current_date": "2022-09-01",
      "security_code": "123456",
      "numbers_with_names": "#1024: Kevin"
    };
    dynamic obj = jsonDecode(json) as Map<String, dynamic>;
    Label label = Label.fromJson(obj);
    LabelPainter painter = LabelPainter(label, data);

    return Column(
      children: [
        SizedBox(
          width: label.paperSize[0],
          height: label.paperSize[1],
          child: CustomPaint(
            painter: painter,
          ),
        ),
        Expanded(child: SizedBox()),
        SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: () {
                  final recorder = PictureRecorder();
                  final canvas = Canvas(
                      recorder,
                      Rect.fromLTWH(
                          0, 0, label.paperSize[0], label.paperSize[1]));
                  painter.paint(
                      canvas, Size(label.paperSize[0], label.paperSize[1]));
                  Picture picture = recorder.endRecording();
                  picture
                      .toImage(label.paperSize[0].toInt(),
                          label.paperSize[1].toInt())
                      .then((image) {
                    PrinterManager().print(image).then((result) {
                      Fluttertoast.showToast(
                          msg: result.message ?? "Failed to print");
                    });
                  });
                },
                child: Text("Print")))
      ],
    );
  }
}

class LabelPainter extends CustomPainter {
  final Label _label;
  final Map<String, dynamic> data;

  LabelPainter(this._label, this.data);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);
    for (var obj in _label.objects) {
      if (obj.type == LabelObjectType.text) {
        LabelTextObject textObj = obj as LabelTextObject;
        TextPainter tp = TextPainter(
          text: TextSpan(
            text: data[textObj.name] ?? "",
            style: TextStyle(
              color: Color(int.parse(
                  textObj.color?.replaceAll("#", "FF") ?? "FF000000",
                  radix: 16)),
              backgroundColor: textObj.background != null
                  ? Color(int.parse(
                      textObj.background?.replaceAll("#", "FF") ?? "FF000000",
                      radix: 16))
                  : null,
              //color: Colors.black,
              fontSize: textObj.size?.toDouble() ?? 12.0,
              fontFamily: "Lato",
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout(
          minWidth: 0,
          maxWidth: size.width,
        );
        tp.paint(
          canvas,
          Offset(obj.at?[0] ?? 0.0, obj.at?[1] ?? 0.0),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
