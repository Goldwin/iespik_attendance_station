import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/domains/attendance/entities/label.dart';

class TestCanvas extends StatefulWidget {
  const TestCanvas({super.key});

  @override
  State<TestCanvas> createState() => _TestCanvasState();
}

class _TestCanvasState extends State<TestCanvas> {
  @override
  Widget build(BuildContext context) {
    String json =
        '{"id":"1", "name":"Test Run","paperSize":[288.0,166.5],"margin":[0.0,0.0,0.0,0.0],"objects":[{"type":"text","name":"Current Date","color":"#000000","background":null,"font":"Lato","styles":[],"overflow":"shrinkToFit","align":"center","valign":"center","vertical":false,"at":[21.95,9.75],"width":248.2,"height":26.6,"size":24},{"type":"text","name":"Security Code","color":"#ffffff","background":"#000000","font":"Lato","styles":["bold"],"overflow":"truncate","align":"center","valign":"center","vertical":false,"at":[17.3,52.15],"width":253.2,"height":62.65,"size":36},{"at":[34.56,124.875],"width":218.88,"height":31.21875,"type":"text","align":"center","color":"#000000","size":48,"valign":"bottom","vertical":false,"styles":["bold"],"padding":2,"overflow":"shrinkToFitAndWrap","rotate":0,"name":"Numbers with Names"}],"orientation":"landscape"}';

    dynamic obj = jsonDecode(json) as Map<String, dynamic>;
    Label label = Label.fromJson(obj);

    return const Placeholder();
  }
}
