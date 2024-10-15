enum LabelObjectType { text, image, verticalLine, horizontalLine }

enum LabelOrientation { landscape, portrait }

abstract class LabelObject {
  LabelObjectType type;

  LabelObject(this.type);
}

class LabelImageObject extends LabelObject {
  String image;

  LabelImageObject(this.image) : super(LabelObjectType.image);

  factory LabelImageObject.fromJson(Map<String, dynamic> json) {
    return LabelImageObject(json['image']);
  }
}

abstract class LabelLineObject extends LabelObject {
  List<double> at;
  double width;
  double height;
  String strokeColor;

  LabelLineObject(
      this.at, this.width, this.height, this.strokeColor, LabelObjectType type)
      : super(type);
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

class LabelTextObject extends LabelObject {
  String? name;
  String? color;
  List<String>? styles;
  int? size;
  List<double>? at;
  double? width;
  double? height;
  String? overflow;
  String? align;
  String? valign;

  LabelTextObject(
    this.name,
    this.color,
    this.styles,
    this.size,
    this.at,
    this.width,
    this.height,
    this.overflow,
    this.align,
    this.valign,
  ) : super(LabelObjectType.text);

  factory LabelTextObject.fromJson(Map<String, dynamic> json) {
    return LabelTextObject(
      json['name'],
      json['color'],
      List<String>.from(json['styles']),
      json['size'],
      List<double>.from(json['at']),
      json['width'],
      json['height'],
      json['overflow'],
      json['align'],
      json['valign'],
    );
  }
}

class LabelObjectFactory {
  static LabelObjectFactory? _instance;
  Map<String, LabelObject Function(dynamic)> mapper = {};

  LabelObjectFactory() {
    mapper[LabelObjectType.text.name] =
        (json) => LabelTextObject.fromJson(json);
    mapper[LabelObjectType.image.name] =
        (json) => LabelImageObject.fromJson(json);
    mapper[LabelObjectType.horizontalLine.name] =
        (json) => LabelHorizontalLineObject.fromJson(json);
    mapper[LabelObjectType.verticalLine.name] =
        (json) => LabelVerticalLineObject.fromJson(json);
  }

  factory LabelObjectFactory.getInstance() {
    _instance ??= LabelObjectFactory();

    return _instance!;
  }

  LabelObject? fromJson(dynamic obj) {
    Map<String, dynamic> map = obj as Map<String, dynamic>;
    LabelObject Function(dynamic p1)? f = mapper[map['type']];

    if (f == null) {
      return null;
    }
    return f(obj);
  }
}

class Label {
  String id;
  String name;
  List<double> paperSize;
  List<double> margin;
  List<LabelObject> objects = [];
  LabelOrientation orientation;

  Label(this.id, this.name, this.paperSize, this.margin, this.objects,
      this.orientation);

  factory Label.fromJson(Map<String, dynamic> json) {
    List<dynamic> objects = json['objects'];
    List<LabelObject> labelObjects = objects
        .map((obj) => LabelObjectFactory.getInstance().fromJson(obj))
        .where((obj) => obj != null)
        .map((obj) => obj!)
        .toList();

    return Label(
        json['id'],
        json['name'],
        List<double>.from(json['paperSize']),
        List<double>.from(json['margin']),
        labelObjects,
        LabelOrientation.values.byName(json['orientation']));
  }
}
