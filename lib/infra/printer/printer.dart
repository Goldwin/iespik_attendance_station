import 'dart:io';

class Printer {
  String? model;
  String? localName;

  Printer.fromMap(Map<String, dynamic> map, channel) {
    model = map['model'] as String;
    localName = map['localName'] as String;
  }

  void print(File file) {}

  Printer({this.model, this.localName});
}
