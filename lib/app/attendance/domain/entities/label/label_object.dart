enum LabelObjectType { text, image, verticalLine, horizontalLine, rectangle }

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

class LabelImageObject extends LabelObject {
  String image;

  LabelImageObject(this.image)
      : super(
            type: LabelObjectType.image,
            position: LabelObjectPosition.origin());

  factory LabelImageObject.fromJson(Map<String, dynamic> json) {
    return LabelImageObject(json['image']);
  }
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

abstract class LabelLineObject extends LabelObject {
  List<double> at;
  double width;
  double height;
  String strokeColor;

  LabelLineObject(
      this.at, this.width, this.height, this.strokeColor, LabelObjectType type)
      : super(type: type, position: LabelObjectPosition.origin());
}

class LabelVerticalLineObject extends LabelLineObject {
  LabelVerticalLineObject(
    List<double> at,
    double width,
    double height,
    String strokeColor,
  ) : super(
          at,
          width,
          height,
          strokeColor,
          LabelObjectType.verticalLine,
        );

  factory LabelVerticalLineObject.fromJson(Map<String, dynamic> json) {
    return LabelVerticalLineObject(
      json['at'],
      json['width'],
      json['height'],
      json['strokeColor'],
    );
  }
}

class LabelHorizontalLineObject extends LabelLineObject {
  LabelHorizontalLineObject(
    List<double> at,
    double width,
    double height,
    String strokeColor,
  ) : super(
          at,
          width,
          height,
          strokeColor,
          LabelObjectType.verticalLine,
        );

  factory LabelHorizontalLineObject.fromJson(Map<String, dynamic> json) {
    return LabelHorizontalLineObject(
      json['at'],
      json['width'],
      json['height'],
      json['strokeColor'],
    );
  }
}
