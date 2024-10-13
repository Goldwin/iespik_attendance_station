package org.iespik.iespik_attendance_station

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import org.iespik.printer.PrinterManager

class MainActivity : FlutterActivity() {
    private val channel = "org.iespik.printer.PrinterManager"
    private val printerManager: PrinterManager = PrinterManager()

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "listPrinters" -> {
                    result.success(printerManager.listPrinters(context).map { it.toMap() })
                }

                "ping" -> result.success("pong")
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
