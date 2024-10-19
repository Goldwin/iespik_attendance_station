import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'label_image_object.dart';
import 'label_line_object.dart';
import 'label_object.dart';
import 'label_text_object.dart';

class LabelObjectFactory {
  static LabelObjectFactory? _instance;
  Map<String, Future<LabelObject> Function(dynamic)> mapper = {};

  LabelObjectFactory() {
    mapper[LabelObjectType.text.name] =
        (json) async => LabelTextObject.fromJson(json);
    mapper[LabelObjectType.image.name] = (json) async {
      json['image'] = await decodeImageFromList(base64Decode(json['image']));
      return LabelImageObject.fromJson(json);
    };
    mapper[LabelObjectType.horizontalLine.name] =
        (json) async => LabelHorizontalLineObject.fromJson(json);
    mapper[LabelObjectType.verticalLine.name] =
        (json) async => LabelVerticalLineObject.fromJson(json);
    mapper[LabelObjectType.rectangle.name] =
        (json) async => LabelRectangleObject.fromJson(json);
  }

  factory LabelObjectFactory.getInstance() {
    _instance ??= LabelObjectFactory();

    return _instance!;
  }

  Future<LabelObject?> fromJson(dynamic obj) async {
    Map<String, dynamic> map = obj as Map<String, dynamic>;
    Future<LabelObject> Function(dynamic p1)? f = mapper[map['type']];

    if (f == null) {
      return null;
    }
    return f(obj);
  }
}
