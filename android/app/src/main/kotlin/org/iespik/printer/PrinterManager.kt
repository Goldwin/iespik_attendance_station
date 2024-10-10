package org.iespik.printer

import android.content.Context
import com.brother.sdk.lmprinter.BLESearchOption
import com.brother.sdk.lmprinter.Channel
import com.brother.sdk.lmprinter.PrinterSearcher
import io.flutter.Log

class PrinterManager {
    private lateinit var printers: Map<String, Printer>

    fun listPrinters(context: Context): List<Printer> {
        val option = BLESearchOption(15.0)
        val result = PrinterSearcher.startBLESearch(context, option) { channel ->
            val modelName = channel.extraInfo[Channel.ExtraInfoKey.ModelName] ?: ""
            val localName = channel.channelInfo
            Log.d("TAG", "Model : $modelName, Local Name: $localName")
        }

        val printerResults = result.channels.map { BrotherPrinter(it) }

        printers = printerResults.associateBy { it.getLocalName() }
        return printerResults
    }
}