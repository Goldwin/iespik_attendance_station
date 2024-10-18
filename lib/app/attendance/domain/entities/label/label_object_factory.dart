import 'label_object.dart';
import 'label_text_object.dart';

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
    mapper[LabelObjectType.rectangle.name] =
        (json) => LabelRectangleObject.fromJson(json);
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
