import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iespik_attendance_station/core/domains/printer/index.dart';

class PrinterList extends StatefulWidget {
  final PrinterComponent printerComponent;
  const PrinterList({required this.printerComponent, super.key});

  @override
  State<PrinterList> createState() => _PrinterListState();
}

class _PrinterListState extends State<PrinterList> {
  List<Printer> _printers = [];
  Printer? _selectedPrinter;
  bool _isLoaded = false;
  bool _isCurrentlyTesting = false;

  void _fetchPrinterList() {
    widget.printerComponent.getPrinterQueries().listPrinters().then((p) {
      setState(() {
        _printers = p;
        _isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      _fetchPrinterList();
      widget.printerComponent.getPrinterQueries().getSelectedPrinter().then((p) {
        setState(() {
          _selectedPrinter = p;
        });
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
                                  widget.printerComponent.getPrinterCommands().selectPrinter(p).then((p) => setState(() {
                                    _selectedPrinter = p;
                                  }));
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
                      widget.printerComponent.getPrinterCommands().testPrint().then((result) {
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
