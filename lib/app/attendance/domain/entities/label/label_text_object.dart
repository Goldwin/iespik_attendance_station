import 'label_object.dart';

class LabelTextObject extends LabelObject {
  String? name;
  String? color;
  List<String>? styles;
  int size;
  double width;
  double height;
  String? overflow;
  String? align;
  String? background;

  LabelTextObject(
      {required super.position,
      required this.size,
      required this.width,
      required this.height,
      this.name,
      this.color,
      this.styles,
      this.overflow,
      this.align,
      this.background})
      : super(type: LabelObjectType.text);

  factory LabelTextObject.fromJson(Map<String, dynamic> json) {
    List<double>? at = List<double>.from(json['at'] ?? [0.0, 0.0]);
    LabelObjectPosition position = LabelObjectPosition(left: at[0], top: at[1]);

    return LabelTextObject(
        name: json['name'],
        color: json['color'],
        styles: List<String>.from(json['styles']),
        size: json['size'],
        width: json['width'],
        height: json['height'],
        overflow: json['overflow'],
        align: json['align'],
        background: json['background'],
        position: position);
  }
}
