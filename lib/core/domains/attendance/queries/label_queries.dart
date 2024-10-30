import 'dart:convert';

import 'package:flutter/services.dart';

import '../entities/label/label.dart';

abstract class LabelQueries {
  Future<List<Label>> getLabels();
}

Future<Label> getLabel(String id) async {
  String content = await rootBundle.loadString('assets/$id.json');
  Map<String, dynamic> json = jsonDecode(content);
  return Label.fromJson(json);
}
