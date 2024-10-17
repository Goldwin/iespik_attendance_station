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
  List<Printer> _printers = [];
  Printer? _selectedPrinter;
  bool _isLoaded = false;
  bool _isCurrentlyTesting = false;

  void _fetchPrinterList() {
    printerManager.listPrinters().then((p) {
      setState(() {
        _printers = p;
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedPrinter = printerManager.getSelectedPrinter();
    if (!_isLoaded) {
      printerManager.ping().then((pong) {
        Fluttertoast.showToast(
            msg: "Successfully Ping to device platform. ping response: $pong");

        _fetchPrinterList();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _fetchPrinterList();
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
                padding: EdgeInsets.only(top: 10),
                children: _printers.isNotEmpty
                    ? _printers
                        .map((p) => ListTile(
                              leading: Icon(Icons.print),
                              trailing: _selectedPrinter != null &&
                                      _selectedPrinter?.localName == p.localName
                                  ? Icon(Icons.check)
                                  : null,
                              title: Text(p.model ?? "No Name"),
                              onTap: () {
                                setState(() {
                                  printerManager.selectPrinter(p);
                                });
                              },
                            ))
                        .toList()
                    : <Widget>[ListTile(title: Text("No Printer Found"))]),
          ),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isCurrentlyTesting
                  ? null
                  : () {
                      if (_isCurrentlyTesting) {
                        return;
                      }
                      setState(() {
                        _isCurrentlyTesting = true;
                      });
                      printerManager.testPrinter().then((result) {
                        setState(() {
                          _isCurrentlyTesting = false;
                        });
                        Fluttertoast.showToast(
                            msg: result.message ??
                                "Print ${result.success ? "Success" : "Failed"}");
                      });
                    },
              child: Text("Test Print"),
            ),
          )
        ],
      ),
    );
  }
}
