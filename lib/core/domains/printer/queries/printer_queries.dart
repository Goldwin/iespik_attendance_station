import '../entities/printer.dart';

mixin PrinterQueries {
  Future<List<Printer>> listPrinters();

  Future<Printer?> getSelectedPrinter();
}