import 'dart:ui';

import 'label_object.dart';

class LabelImageObject extends LabelObject {
  Image image;
  double width;
  double height;

  LabelImageObject(
      {required this.image,
      required List<double> at,
      required this.width,
      required this.height})
      : super(
            type: LabelObjectType.image,
            position: LabelObjectPosition(left: at[0], top: at[1]));

  factory LabelImageObject.fromJson(Map<String, dynamic> json) {
    return LabelImageObject(
        image: json['image'],
        at: List<double>.from(json['at']),
        width: json['width'],
        height: json['height']);
  }
}
