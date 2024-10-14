package org.iespik.printer

import android.content.Context
import com.brother.bfelement.BFElementModelDefinition.ModelName
import com.brother.sdk.lmprinter.Channel
import com.brother.sdk.lmprinter.PrinterSearcher
import io.flutter.Log
import java.io.File

class PrinterManager {
    private lateinit var printers: Map<String, Printer>

    fun listPrinters(context: Context): List<Printer> {
        Log.d("LabelPrinter", "Starting BLE Search for Label Printers")
        val result = PrinterSearcher.startBluetoothSearch(context)

        Log.d("LabelPrinter", "Found ${result.channels.size} Label Printers")
        val printerResults =
            result.channels.filter { isPrinterDevice(it) }.map { BrotherPrinter(it) }

        for (printer in printerResults) {
            Log.d(
                "LabelPrinter",
                "Found Label Printer: ${printer.getLocalName()} (${printer.getModel()})"
            )
        }

        printers = printerResults.associateBy { it.getLocalName() }
        return printerResults
    }

    private fun isPrinterDevice(channel: Channel): Boolean {
        val modelName = channel.extraInfo[Channel.ExtraInfoKey.ModelName] ?: ""
        //TODO implement with better idea
        return modelName.replace('-', '_').startsWith(ModelName.QL_820NWB.toString())
    }

    fun print(printerLocalName: String?, filePath: String?): PrintResult {
        when {
            printerLocalName == null -> {
                return PrintResult.PrinterNotFoundError
            }

            filePath == null -> {
                return PrintResult.InvalidPathError
            }
        }

        val file = File(filePath!!)
        val result = printers[printerLocalName]?.print(file) ?: PrintResult.PrinterNotFoundError

        return result
    }
}