import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/station/widgets/double_back_pop_scope.dart';
import 'package:iespik_attendance_station/app/station/widgets/printer_list.dart';
import 'package:iespik_attendance_station/app/station/widgets/station_drawer.dart';
import 'package:iespik_attendance_station/app/station/widgets/station_leading.dart';

class PrinterConfigScreen extends StatefulWidget {
  const PrinterConfigScreen({super.key});

  @override
  State<PrinterConfigScreen> createState() => _PrinterConfigScreenState();
}

class _PrinterConfigScreenState extends State<PrinterConfigScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: StationLeading(),
        title: const Text('Printer Configuration'),
      ),
      drawer: StationDrawer(),
      body: DoubleBackQuit(child: PrinterList()),
    );
  }
}
