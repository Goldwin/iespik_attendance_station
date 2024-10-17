import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:iespik_attendance_station/infra/printer/print_result.dart';
import 'package:iespik_attendance_station/infra/printer/printer.dart';
import 'package:path_provider/path_provider.dart';

class PrinterManager {
  static final PrinterManager _instance = PrinterManager._internal();
  Printer? _selectedPrinter;

  final MethodChannel _channel =
      MethodChannel('org.iespik.printer.PrinterManager');

  PrinterManager._internal();

  factory PrinterManager() => _instance;

  Future<List<Printer>> listPrinters() async {
    List<Map<dynamic, dynamic>>? printers =
        await _channel.invokeListMethod("listPrinters");
    if (printers != null) {
      return printers.map((p) => Printer.fromMap(p)).toList();
    }

    return [];
  }

  Future<PrintResult> print(Image img) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = '$tempPath/label.png';
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
    if (pngBytes == null) {
      return PrintResult.failed("Failed to convert image to PNG");
    }
    final buffer = pngBytes.buffer;
    File file = await File(filePath).writeAsBytes(
      buffer.asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes),
    );

    Map<dynamic, dynamic>? result = await _channel.invokeMapMethod("print", {
      "printerLocalName": _selectedPrinter?.localName,
      "filePath": file.path
    });

    if (result != null) {
      return PrintResult.fromMap(result);
    }

    return PrintResult.failed("Failed to connect to printer");
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

    return PrintResult.failed("Failed to connect to printer");
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
