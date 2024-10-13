import 'package:flutter/services.dart';
import 'package:iespik_attendance_station/infra/printer/printer.dart';

class PrinterManager {
  MethodChannel channel = MethodChannel('org.iespik.printer.PrinterManager');

  Future<List<Printer>> listPrinters() async {
    List<Map<dynamic, dynamic>>? printers =
        await channel.invokeListMethod("listPrinters");
    if (printers != null) {
      return printers.map((p) => Printer.fromMap(p, channel)).toList();
    }

    return [];
  }

  Future<String> ping() async {
    return await channel.invokeMethod("ping") as String;
  }
}

PrinterManager printerManager = PrinterManager();
