import 'commands/printer_commands.dart';
import 'queries/printer_queries.dart';

abstract class PrinterComponent {
  PrinterCommands getPrinterCommands();

  PrinterQueries getPrinterQueries();
}