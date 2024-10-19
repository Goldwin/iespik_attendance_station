import 'label_object.dart';

abstract class LabelLineObject extends LabelObject {
  List<double> startPoint;
  List<double> endPoint;
  String? strokeColor;
  int? size;

  LabelLineObject(
      {required this.startPoint,
      required this.endPoint,
      this.size = 1,
      this.strokeColor = "#000000"})
      : super(
            type: LabelObjectType.line, position: LabelObjectPosition.origin());
}

class LabelVerticalLineObject extends LabelLineObject {
  LabelVerticalLineObject(
      {required List<double> at,
      required double length,
      super.strokeColor,
      super.size})
      : super(
          startPoint: at,
          endPoint: [at[0], at[1] + length],
        );

  factory LabelVerticalLineObject.fromJson(Map<String, dynamic> json) {
    return LabelVerticalLineObject(
        at: List<double>.from(json['at']),
        length: json['length'],
        strokeColor: json['strokeColor'],
        size: json['size']);
  }
}

class LabelHorizontalLineObject extends LabelLineObject {
  LabelHorizontalLineObject(
      {required List<double> at,
      required double length,
      super.strokeColor,
      super.size})
      : super(
          startPoint: at,
          endPoint: [at[0] + length, at[1]],
        );

  factory LabelHorizontalLineObject.fromJson(Map<String, dynamic> json) {
    return LabelHorizontalLineObject(
        at: List<double>.from(json['at']),
        length: json['length'],
        strokeColor: json['strokeColor'],
        size: json['size']);
  }
}
