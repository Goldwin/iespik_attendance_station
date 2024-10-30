class Printer {
  String? model;
  String? localName;

  Printer.fromJson(Map<dynamic, dynamic> map) {
    model = map['model'] as String;
    localName = map['localName'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model'] = model;
    data['localName'] = localName;
    return data;
  }

  Printer({this.model, this.localName});
}
