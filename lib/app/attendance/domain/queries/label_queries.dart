import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:iespik_attendance_station/app/attendance/domain/entities/label/label.dart';

Future<Label> getLabel(String id) async {
  String content = await rootBundle.loadString('assets/$id.json');
  Map<String, dynamic> json = jsonDecode(content);
  return Label.fromJson(json);
}
