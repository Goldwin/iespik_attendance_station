import 'dart:ui';

import '../entities/printer.dart';
import '../entities/print_result.dart';

mixin PrinterCommands {
  Future<PrintResult> print(Image img);

  Future<Printer> selectPrinter(Printer printer);

  Future<PrintResult> testPrint();
}