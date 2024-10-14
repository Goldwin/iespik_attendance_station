import 'dart:io';

import 'package:flutter/services.dart';
import 'package:iespik_attendance_station/infra/printer/print_result.dart';
import 'package:iespik_attendance_station/infra/printer/printer.dart';
import 'package:path_provider/path_provider.dart';

class PrinterManager {
  final MethodChannel _channel =
      MethodChannel('org.iespik.printer.PrinterManager');
  Printer? _selectedPrinter;

  Future<List<Printer>> listPrinters() async {
    List<Map<dynamic, dynamic>>? printers =
        await _channel.invokeListMethod("listPrinters");
    if (printers != null) {
      return printers.map((p) => Printer.fromMap(p)).toList();
    }

    return [];
  }

  Future<String> ping() async {
    return await _channel.invokeMethod("ping") as String;
  }

  void selectPrinter(Printer printer) {
    _selectedPrinter = printer;
  }

  Printer? getSelectedPrinter() {
    return _selectedPrinter;
  }

  Future<PrintResult> testPrinter() async {
    File file = await _getTestLabelFile();

    Map<dynamic, dynamic>? result = await _channel.invokeMapMethod("print", {
      "printerLocalName": _selectedPrinter?.localName,
      "filePath": file.path
    });

    if (result != null) {
      return PrintResult.fromMap(result);
    }

    return PrintResult.failed();
  }

  Future<File> _getTestLabelFile() async {
    final byteData = await rootBundle.load('images/test_label.png');
    final buffer = byteData.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/test_label.png';
    return File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}

PrinterManager printerManager = PrinterManager();
