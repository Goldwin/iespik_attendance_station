enum LabelObjectType {
  text,
  image,
  line,
  verticalLine,
  horizontalLine,
  rectangle
}

enum LabelOrientation { landscape, portrait }

class LabelObjectPosition {
  double top;
  double left;

  LabelObjectPosition({required this.left, required this.top});

  LabelObjectPosition.origin() : this(left: 0.0, top: 0.0);
}

abstract class LabelObject {
  LabelObjectType type;
  LabelObjectPosition position;

  LabelObject({
    required this.position,
    this.type = LabelObjectType.text,
  });
}

class LabelRectangleObject extends LabelObject {
  List<double> at;
  double width;
  double height;
  String strokeColor;
  String fillColor;

  LabelRectangleObject(
      this.at, this.width, this.height, this.strokeColor, this.fillColor)
      : super(
            type: LabelObjectType.rectangle,
            position: LabelObjectPosition.origin());

  factory LabelRectangleObject.fromJson(Map<String, dynamic> json) {
    return LabelRectangleObject(
      json['at'],
      json['width'],
      json['height'],
      json['strokeColor'],
      json['fillColor'],
    );
  }
}
