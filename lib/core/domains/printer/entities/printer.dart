class Printer {
  String? model;
  String? localName;

  Printer.fromJson(Map<dynamic, dynamic> map) {
    model = map['model'] as String;
    localName = map['localName'] as String;
  }

  Printer({this.model, this.localName});
}
