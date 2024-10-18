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
