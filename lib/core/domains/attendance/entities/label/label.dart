import 'label_object.dart';
import 'label_object_factory.dart';

class Label {
  String id;
  String name;
  List<double> paperSize;
  List<double> margin;
  List<LabelObject> objects = [];
  LabelOrientation orientation;

  Label(this.id, this.name, this.paperSize, this.margin, this.objects,
      this.orientation);

  static Future<Label> fromJson(Map<String, dynamic> json) async {
    List<dynamic> objects = json['objects'];
    List<LabelObject> labelObjects = [];

    for (final obj in objects) {
      final labelObject = await LabelObjectFactory.getInstance().fromJson(obj);
      if (labelObject != null) {
        labelObjects.add(labelObject);
      }
    }

    return Label(
        json['id'],
        json['name'],
        List<double>.from(json['paperSize']),
        List<double>.from(json['margin']),
        labelObjects,
        LabelOrientation.values.byName(json['orientation']));
  }
}
