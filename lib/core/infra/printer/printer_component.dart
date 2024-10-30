import 'package:iespik_attendance_station/core/infra/printer/printer_manager.dart';

import '../../domains/printer/index.dart';

class PrinterComponentImpl extends PrinterComponent {
  final PrinterManager printerManager = PrinterManager();
  
  @override
  PrinterCommands getPrinterCommands() {
    return printerManager;
  }

  @override
  PrinterQueries getPrinterQueries() {
    return printerManager;
  }
  
}