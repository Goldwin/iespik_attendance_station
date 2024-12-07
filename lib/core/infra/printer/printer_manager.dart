import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domains/printer/commands/printer_commands.dart';
import '../../domains/printer/entities/print_result.dart';
import '../../domains/printer/entities/printer.dart';
import '../../domains/printer/queries/printer_queries.dart';

class PrintingTask {
  final int id;
  final Image img;
  final Completer<PrintResult> completer = Completer<PrintResult>();

  PrintingTask({required this.id, required this.img});
}

class PrinterManager implements PrinterQueries, PrinterCommands {
  Printer? _selectedPrinter;
  int id = 0;
  final Directory tempDir = Directory.systemTemp;

  final MethodChannel _channel =
      MethodChannel('org.iespik.printer.PrinterManager');

  @override
  Future<List<Printer>> listPrinters() async {
    List<Map<dynamic, dynamic>>? printers =
        await _channel.invokeListMethod("listPrinters");
    if (printers != null) {
      return printers.map((p) => Printer.fromJson(p)).toList();
    }

    return [];
  }

  @override
  Future<PrintResult> print(Image img) async {
    if (_selectedPrinter == null) {
      return PrintResult.failed("No printer selected");
    }
    var task = PrintingTask(id: ++id, img: img);
    _executeTask(task);
    return task.completer.future;
  }

  Future<String> ping() async {
    return await _channel.invokeMethod("ping") as String;
  }

  @override
  Future<Printer?> getSelectedPrinter() async {
    if (_selectedPrinter == null) {
      var pref = await SharedPreferences.getInstance();
      String? json = pref.getString('selectedPrinter');
      if (json != null) {
        _selectedPrinter = Printer.fromJson(jsonDecode(json));
      }
    }
    return _selectedPrinter;
  }

  @override
  Future<PrintResult> testPrint() async {
    if (_selectedPrinter == null) {
      return PrintResult.failed("No printer selected");
    }
    File file = await _getTestLabelFile();

    Map<dynamic, dynamic>? result = await _channel.invokeMapMethod("print", {
      "printerLocalName": _selectedPrinter?.localName,
      "filePath": file.path
    });

    if (result != null) {
      return PrintResult.fromJson(result);
    }

    return PrintResult.failed("Failed to connect to printer");
  }

  void _executeTask(PrintingTask task) {
    String tempPath = tempDir.path;
    var filePath = '$tempPath/${task.id}';
    task.img.toByteData(format: ImageByteFormat.png).then((pngBytes) async {
      if (pngBytes == null) {
        task.completer
            .complete(PrintResult.failed("Failed to convert image to PNG"));
        return;
      }
      final buffer = pngBytes.buffer;
      File file;
      try {
        file = await File(filePath).writeAsBytes(
          buffer.asUint8List(pngBytes.offsetInBytes, pngBytes.lengthInBytes),
        );
      } catch (e) {
        return task.completer.complete(PrintResult.failed(e.toString()));
      }

      try {
        Map<dynamic, dynamic>? result = await _channel.invokeMapMethod(
            "print", {
          "printerLocalName": _selectedPrinter?.localName,
          "filePath": file.path
        });

        if (result != null) {
          task.completer.complete(PrintResult.fromJson(result));
          return;
        }
        task.completer
            .complete(PrintResult.failed("Failed to connect to printer"));
        return;
      } finally {
        file.delete();
      }
    });
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

  @override
  Future<Printer> selectPrinter(Printer printer) async {
    var pref = await SharedPreferences.getInstance();
    _selectedPrinter = printer;
    pref.setString('selectedPrinter', jsonEncode(printer));
    return printer;
  }
}
