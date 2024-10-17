import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/printer_list.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/station_drawer.dart';
import 'package:iespik_attendance_station/app/attendance/widgets/station_leading.dart';
import 'package:iespik_attendance_station/app/commons/double_back_pop_scope.dart';
import 'package:permission_handler/permission_handler.dart';

class PrinterConfigScreen extends StatefulWidget {
  const PrinterConfigScreen({super.key});

  @override
  State<PrinterConfigScreen> createState() => _PrinterConfigScreenState();
}

class _PrinterConfigScreenState extends State<PrinterConfigScreen> {
  @override
  Widget build(BuildContext context) {
    _requestPermission();
    return Scaffold(
      appBar: AppBar(
        leading: StationLeading(),
        title: const Text('Printer Configuration'),
      ),
      drawer: StationDrawer(),
      body: DoubleBackQuit(child: PrinterList()),
    );
  }

  Future<void> _requestPermission() async {
    [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect
    ].request();
  }
}
