import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/infra/printer/printer_manager.dart';

import '../../../infra/printer/printer.dart';

class PrinterList extends StatefulWidget {
  const PrinterList({super.key});

  @override
  State<PrinterList> createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterList> {
  List<Printer> printers = [];
  bool isLoaded = false;

  void _fetchPrinterList() {
    printerManager.listPrinters().then((p) {
      setState(() {
        printers = p;
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    printerManager.ping().then((pong) {
      Fluttertoast.showToast(
          msg: "Successfully Ping to device platform. ping response: $pong");

      if (!isLoaded) {
        _fetchPrinterList();
      }
    });
    return RefreshIndicator(
      onRefresh: () async {
        _fetchPrinterList();
      },
      child: ListView(
        children: printers
            .map((p) => ListTile(
                  title: Text(p.localName ?? "No Name"),
                ))
            .toList(),
      ),
    );
  }
}
