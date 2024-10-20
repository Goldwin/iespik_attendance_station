import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/label/label.dart';
import 'package:iespik_attendance_station/app/attendance/domain/queries/label_queries.dart';
import 'package:iespik_attendance_station/app/attendance/utilities/label/label_painter.dart';
import 'package:iespik_attendance_station/infra/printer/printer_manager.dart';

class TestCanvas extends StatefulWidget {
  const TestCanvas({super.key});

  @override
  State<TestCanvas> createState() => _TestCanvasState();
}

class _TestCanvasState extends State<TestCanvas> {
  Label? _label;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      "currentDate": "01 September 2024",
      "securityCode": "A12B",
      "numbersWithName": "#1024: John",
      "firstName": "John",
      "lastName": "Nolan",
      "kind": "Regular",
      "currentDateWithActivity": "01 September 2024 - Kids' Church",
      "checkedInBy": "Chris Nolan"
    };

    LabelPainter? painter = _label == null ? null : LabelPainter(_label!, data);

    return Column(
      children: [
        ListTile(
            title: Text("Adult Label"),
            onTap: () {
              getLabel("adult_label").then((label) {
                setState(() {
                  _label = label;
                });
              });
            }),
        ListTile(
          title: Text("Kids Label"),
          onTap: () {
            getLabel("kid_label").then((label) {
              setState(() {
                _label = label;
              });
            });
          },
        ),
        ListTile(
          title: Text("Security Label"),
          onTap: () {
            getLabel("security_label").then((label) {
              setState(() {
                _label = label;
              });
            });
          },
        ),
        ListTile(
          title: Text("Volunteer"),
          onTap: () {
            getLabel("volunteer").then((label) {
              setState(() {
                _label = label;
              });
            });
          },
        ),
        _label != null
            ? SizedBox(
                width: _label!.paperSize[0],
                height: _label!.paperSize[1],
                child: CustomPaint(
                  painter: painter,
                ),
              )
            : SizedBox(),
        Expanded(child: SizedBox()),
        SizedBox(
            width: double.infinity,
            child: FilledButton(
                onPressed: () {
                  final recorder = PictureRecorder();
                  final canvas = Canvas(
                      recorder,
                      Rect.fromLTWH(
                          0, 0, _label!.paperSize[0], _label!.paperSize[1]));
                  painter?.paint(
                      canvas, Size(_label!.paperSize[0], _label!.paperSize[1]));
                  Picture picture = recorder.endRecording();
                  picture
                      .toImage(_label!.paperSize[0].toInt(),
                          _label!.paperSize[1].toInt())
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
