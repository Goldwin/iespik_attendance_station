import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/printer/widgets/printer_list.dart';
import 'package:iespik_attendance_station/app/commons/double_back_pop_scope.dart';
import 'package:iespik_attendance_station/app/commons/screens/screen_template.dart';
import 'package:iespik_attendance_station/core/domains/printer/index.dart';
import 'package:permission_handler/permission_handler.dart';

class PrinterConfigScreen extends StatefulWidget {
  final PrinterComponent printerComponent;
  const PrinterConfigScreen({required this.printerComponent, super.key});

  @override
  State<PrinterConfigScreen> createState() => _PrinterConfigScreenState();
}

class _PrinterConfigScreenState extends State<PrinterConfigScreen> {
  @override
  Widget build(BuildContext context) {
    _requestPermission();
    return ScreenTemplate(body: DoubleBackQuit(child: PrinterList(printerComponent: widget.printerComponent)),title: 'Printer List');
  }

  Future<void> _requestPermission() async {
    [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect
    ].request();
  }
}
